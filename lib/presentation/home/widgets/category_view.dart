import 'package:flutter/material.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/widgets/cards/product.dart';

class CategoryView extends StatelessWidget {
  final HomeLoaded state;
  final AppLocalizations lang;

  const CategoryView({super.key, required this.state, required this.lang});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: state.categories.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.localeName == "en" ? category.ename : category.arname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = category.products![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ProductCard(product: product),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
