import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';

class QuantityControllerWidget extends StatelessWidget {
  final int productId;
  final double height;
  final double width;

  const QuantityControllerWidget({
    super.key,
    required this.productId,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final qty = cubit.getQuantity(productId);
        final stock = cubit.getStock(productId);

        final iconSize = height * 0.45;
        final textSize = height * 0.4;
        final spacing = width * 0.08;

        return SizedBox(
          width: width,
          height: height,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(height * 0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Decrease
                InkWell(
                  onTap: qty > 1
                      ? () => cubit.decrease(productId)
                      : () => cubit.removeFromCart(productId),
                  child: Icon(
                    Icons.remove,
                    size: iconSize,
                    color: AppColors.backGroundColor,
                  ),
                ),

                SizedBox(width: spacing),

                /// Quantity
                Text(
                  qty.toString(),
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                  ),
                ),

                SizedBox(width: spacing),

                /// Increase
                InkWell(
                  onTap: qty < stock ? () => cubit.increase(productId) : null,
                  child: Icon(
                    Icons.add,
                    size: iconSize,
                    color: qty < stock
                        ? AppColors.backGroundColor
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
