import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/widgets/buttons/search/search.dart';
import 'package:trendychef/widgets/cards/product.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (searchController.text.isEmpty) {
        context.read<SearchBloc>().add(Searching(""));
      }
    });

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
                  // 🟩 Search bar + language selector
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          // 🔍 Responsive Search Field
                          Expanded(
                            flex: 8,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double searchWidth = constraints.maxWidth;
                                if (searchWidth > 900) {
                                  searchWidth =
                                      600; // cap width on large screens
                                }
                                return Center(
                                  child: SizedBox(
                                    width: searchWidth,
                                    height: 50,
                                    child: searchField(
                                      context: context,
                                      controller: searchController,
                                      onChanged: (query) {
                                        context.read<SearchBloc>().add(
                                          Searching(query),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
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
              return switch (state) {
                SearchInitial() || SearchLoading() => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SearchLoaded() =>
                  state.products.isEmpty
                      ? _buildEmptyState()
                      : _buildGrid(state.products, context),
                SearchError() => _buildErrorState(),
                _ => const SizedBox.shrink(),
              };
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

  Widget _buildGrid(List<ProductModel> products, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1000
        ? 5
        : screenWidth > 800
        ? 4
        : screenWidth > 600
        ? 3
        : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(1),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 320,
      ),
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}
