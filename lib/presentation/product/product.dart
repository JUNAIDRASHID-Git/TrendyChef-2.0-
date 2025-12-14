import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/product/cubit/product_cubit.dart';
import 'package:trendychef/widgets/buttons/cart/cart.dart';
import 'package:trendychef/widgets/cards/image.dart';
import 'package:trendychef/widgets/cards/product.dart';
import 'package:trendychef/widgets/text/price.dart';
import 'package:trendychef/widgets/text/product_name_text.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId, this.categoryId});

  final String productId;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 768;

    final scrollBehavior = ScrollConfiguration.of(context).copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      },
    );

    return BlocProvider(
      create: (_) =>
          ProductCubit()
            ..loadProduct(productId: productId, categoryId: categoryId),
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: SafeArea(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductError) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is ProductLoaded) {
                final product = state.product;
                final lang = AppLocalizations.of(context)!;

                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: ScrollConfiguration(
                      behavior: scrollBehavior,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isWide ? 40 : 16,
                            vertical: isWide ? 40 : 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Back Button
                              IconButton(
                                onPressed: () {
                                  if (GoRouter.of(context).canPop()) {
                                    context.pop();
                                  } else {
                                    context.go('/home');
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.fontColor.withOpacity(0.8),
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.fontColor
                                      .withOpacity(0.1),
                                  shape: const CircleBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              isWide
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: _buildImageSection(
                                            context,
                                            product,
                                            lang,
                                          ),
                                        ),
                                        const SizedBox(width: 60),
                                        Expanded(
                                          child: _buildDetailsSection(
                                            context,
                                            lang,
                                            product,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        _buildImageSection(
                                          context,
                                          product,
                                          lang,
                                        ),
                                        const SizedBox(height: 30),
                                        _buildDetailsSection(
                                          context,
                                          lang,
                                          product,
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 20),
                              if (state.category != null &&
                                  state.category!.products != null &&
                                  state.category!.products!.isNotEmpty)
                                SizedBox(
                                  height: 340,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lang.recommendedproducts,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.fontColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          primary: false,
                                          itemCount:
                                              state.category!.products!.length,
                                          itemBuilder: (context, index) {
                                            final recommendedProduct = state
                                                .category!
                                                .products![index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: ProductCard(
                                                product: recommendedProduct,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(
    BuildContext context,
    ProductModel product,
    AppLocalizations lang,
  ) {
    return Stack(
      children: [
        ImageCard(imageUrl: product.image, width: 350, height: 350, zoom: true),

        Positioned(
          right: 12,
          top: 12,
          child: IconButton(
            onPressed: () {
              shareProduct(product, lang);
            },
            icon: Icon(Icons.share, color: AppColors.bluefont, size: 28),
          ),
        ),
      ],
    );
  }

  void shareProduct(ProductModel product, AppLocalizations lang) async {
    final bool isArabic = lang.localeName == "ar";

    // OG preview link (used by WhatsApp/Facebook)
    final String ogUrl =
        "https://server.trendy-c.com/public/og/products/${product.id}";

    // Localized product name
    final String productName = isArabic
        ? (product.arName ?? product.eName)
        : product.eName;

    // Message to share
    final String message = isArabic
        ? """
🔥 منتج رائج الآن على ترندي شيف!

$productName

$ogUrl
"""
        : """
🔥 Check this trending product on TrendyChef!

$productName

$ogUrl
""";

    // Subject for apps that show it
    final String subject = isArabic
        ? "🔥 منتج رائج على ترندي شيف"
        : "🔥 Trending Product on TrendyChef";

    await Share.share(message, subject: subject);
  }

  Widget _buildDetailsSection(
    BuildContext context,
    AppLocalizations lang,
    ProductModel product,
  ) {
    final isArabic = lang.localeName == "ar";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductNameText(
          productName: isArabic
              ? (product.arName ?? product.eName)
              : product.eName,
        ),
        const SizedBox(height: 16),
        PriceTextWidget(
          price: product.salePrice,
          regularPrice: product.regularPrice,
          fontSize: 24,
        ),
        const SizedBox(height: 24),
        CartButton(
          item: CartItemModel(
            id: product.id!,
            cartId: 1,
            productId: product.id!,
            productImage: product.image,
            productEName: product.eName,
            productArName: product.arName ?? product.eName,
            stock: product.stock,
            productSalePrice: product.salePrice,
            productRegularPrice: product.regularPrice,
            weight: product.weight,
            quantity: 1,
            addedAt: DateTime.now(),
          ),
        ),
        Text(
          isArabic
              ? (product.arDescription ?? "")
              : (product.eDescription ?? ""),
          style: TextStyle(
            fontSize: 16,
            color: AppColors.fontGrey,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
