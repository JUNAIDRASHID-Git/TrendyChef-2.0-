import 'package:flutter/widgets.dart';
import 'package:trendychef/core/services/models/category/category.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/widgets/category_header.dart';
import 'package:trendychef/widgets/cards/product.dart';

class CategorySection extends StatelessWidget {
  final CategoryModel category;
  final AppLocalizations lang;

  const CategorySection({
    super.key,
    required this.category,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryHeader(
          title: lang.localeName == "en" ? category.ename : category.arname,
          category: category,
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.products?.length ?? 0,
            itemBuilder: (context, index) => ProductCard(
              product: category.products![index],
              categoryId: category.id.toString(),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
