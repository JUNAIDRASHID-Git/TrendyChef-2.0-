import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/widgets/controllers/quantity/quantity_controller.dart';

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
          return QuantityControllerWidget(productId: item.productId);
        }

        return _buildAddToCartButton(context, item.productId);
      },
    );
  }

  Widget _buildAddToCartButton(BuildContext context, int productId) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: AppColors.fontColor.withOpacity(0.2),
        onTap: () async {
          await context.read<CartCubit>().addToCart(productId);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.asset(
              'assets/icons/cart.png',
              width: 20,
              height: 20,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
