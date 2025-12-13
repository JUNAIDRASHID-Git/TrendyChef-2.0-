import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/category/category.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/category/widgets/category_product_screen.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final CategoryModel category;

  const CategoryHeader({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: AppColors.fontColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.0),
                    AppColors.primary.withOpacity(0.5),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryProductScreen(category: category),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.fontColor.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
