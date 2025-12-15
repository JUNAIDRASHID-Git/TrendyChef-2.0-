import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/category/bloc/category_bloc.dart';
import 'package:trendychef/presentation/category/widgets/category_product_screen.dart';
import 'package:trendychef/widgets/buttons/search/fake_search.dart';
import 'package:trendychef/widgets/cards/image.dart';
import 'package:trendychef/widgets/container/error/error_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: const SizedBox(height: 50, child: FakeSearchButton()),
                ),

                const SizedBox(height: 10),

                /// Title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 5,
                  ),
                  child: Text(
                    lang.categories,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /// Category Grid
                Expanded(
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryError) {
                        return ErrorScreen(error: "Server error.");
                      }

                      if (state is! CategoryLoaded) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final categories = (state).categories;

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          double width = constraints.maxWidth;

                          /// Responsive column count
                          int crossAxisCount = width > 1000
                              ? 5
                              : width > 800
                              ? 4
                              : width > 600
                              ? 3
                              : 3;

                          return GridView.builder(
                            padding: const EdgeInsets.all(14),
                            itemCount: categories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.78,
                                ),
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryProductScreen(
                                            category: category,
                                          ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    ImageCard(
                                      imageUrl: category.image!,
                                      width: 100,
                                      height: 100,
                                    ),

                                    const SizedBox(height: 8),

                                    /// Category name
                                    Text(
                                      lang.localeName == "en"
                                          ? category.ename
                                          : category.arname,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.fontColor.withOpacity(
                                          0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
