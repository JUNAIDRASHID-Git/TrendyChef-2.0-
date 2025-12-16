import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/widgets/controllers/quantity/quantity_controller.dart';
import 'package:trendychef/widgets/text/sale_price.dart';

class CartButton extends StatelessWidget {
  final CartItemModel item;
  const CartButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final inCart = cubit.isInCart(item.productId);

        if (inCart) {
          return QuantityControllerWidget(
            productId: item.productId,
            height: 40,
            width: 170,
          );
        }

        if (item.stock < 1) {
          return Container(
            width: 170,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text(
                  "Out Of Stock",
                  style: TextStyle(
                    color: AppColors.backGroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: AppColors.fontColor.withOpacity(0.2),
            onTap: () async {
              await context.read<CartCubit>().addToCart(item.productId);
            },
            child: Container(
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SalePriceWidget(
                      salePrice: item.productSalePrice,
                      fontSize: 18,
                      fontColor: AppColors.backGroundColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/cart1.svg',
                    width: 30,
                    height: 30,
                    color: AppColors.backGroundColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
