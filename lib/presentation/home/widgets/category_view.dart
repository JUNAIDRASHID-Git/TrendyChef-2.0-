import 'package:flutter/material.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/presentation/home/widgets/category_header.dart';
import 'package:trendychef/widgets/cards/product.dart';

class CategoryView extends StatelessWidget {
  final HomeLoaded state;
  final AppLocalizations lang;

  const CategoryView({super.key, required this.state, required this.lang});

  @override
  Widget build(BuildContext context) {
    final shuffledCategories = [...state.categories]..shuffle();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: shuffledCategories.length,
        separatorBuilder: (_, _) => const SizedBox(height: 20),
        itemBuilder: (context, catIndex) {
          final category = shuffledCategories[catIndex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryHeader(
                title: lang.localeName == "en"
                    ? category.ename
                    : category.arname,
                category: category,
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.products?.length ?? 0,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final product = category.products![index];
                    return ProductCard(
                      product: product,
                      categoryId: category.iD.toString(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
