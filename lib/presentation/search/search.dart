import 'dart:async';

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

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _searchController;
  Timer? _debounce;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchBloc>().add(Searching(""));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      context.read<SearchBloc>().add(Searching(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: _SearchAppBar(
        controller: _searchController,
        onChanged: _onSearchChanged,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: BlocBuilder<SearchBloc, SearchState>(
            buildWhen: (previous, current) =>
                current is SearchLoaded ||
                current is SearchLoading ||
                current is SearchError,
            builder: (context, state) {
              if (state is SearchLoading || state is SearchInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SearchError) {
                return const _ErrorState();
              }

              if (state is SearchLoaded) {
                if (state.products.isEmpty) {
                  return const _EmptyState();
                }
                return _ProductGrid(products: state.products);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

/// =======================
/// AppBar (Extracted)
/// =======================
class _SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SearchAppBar({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leadingWidth: 0,
      leading: const SizedBox(),
      flexibleSpace: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 50,
                child: searchField(
                  context: context,
                  controller: controller,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// =======================
/// Product Grid (Optimized)
/// =======================
class _ProductGrid extends StatelessWidget {
  const _ProductGrid({required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey('search_grid'),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemCount: products.length,
      cacheExtent: 600,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 190,
        mainAxisExtent: 300,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return RepaintBoundary(child: ProductCard(product: products[index]));
      },
    );
  }
}

/// =======================
/// Empty State
/// =======================
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================
/// Error State
/// =======================
class _ErrorState extends StatelessWidget {
  const _ErrorState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.error_outline_rounded, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
