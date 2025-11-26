import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';

class QuantityControllerWidget extends StatelessWidget {
  final int productId;
  const QuantityControllerWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final qty = cubit.getQuantity(productId);
        final stock = cubit.getStock(productId);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: qty > 1 ? () => cubit.decrease(productId) : null,
                child: Icon(
                  Icons.remove,
                  size: 14,
                  color: qty > 1 ? AppColors.fontColor : Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 8),
              Text(qty.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              InkWell(
                onTap: qty < stock ? () => cubit.increase(productId) : null,
                child: Icon(
                  Icons.add,
                  size: 14,
                  color: qty < stock ? AppColors.fontColor : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
