import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/widgets/cards/product.dart';
import 'package:trendychef/widgets/buttons/search/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Trigger initial empty search
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchBloc>().add(Searching(""));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        leadingWidth: 0,
        leading: const SizedBox(),
        flexibleSpace: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        height: 50,
                        child: searchField(
                          context: context,
                          controller: _searchController,
                          onChanged: (query) {
                            context.read<SearchBloc>().add(Searching(query));
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading || state is SearchInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SearchLoaded) {
                if (state.products.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildGrid(state.products);
              } else if (state is SearchError) {
                return _buildErrorState();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          'No products found',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  Widget _buildErrorState() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline_rounded, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  Widget _buildGrid(List<ProductModel> products) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1000
        ? 5
        : screenWidth > 800
        ? 4
        : screenWidth > 600
        ? 3
        : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 320,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}
