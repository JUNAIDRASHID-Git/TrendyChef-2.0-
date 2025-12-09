import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

IconData getStatusIcon(String status) {
  switch (status.toLowerCase()) {
    case "pending":
      return Icons.access_time; // clock
    case "confirmed":
      return Icons.check_circle_outline;
    case "ready_to_ship":
      return Icons.local_shipping_outlined;
    case "shipped":
      return Icons.airport_shuttle;
    case "delivered":
      return Icons.home_outlined;
    case "returned":
      return Icons.undo;
    case "cancelled":
      return Icons.cancel;
    default:
      return Icons.info_outline;
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "pending":
      return Colors.orange;
    case "confirmed":
      return Colors.blue;
    case "ready_to_ship":
      return Colors.indigo;
    case "shipped":
      return Colors.teal;
    case "delivered":
      return Colors.green;
    case "returned":
      return Colors.purple;
    case "cancelled":
      return Colors.red;
    default:
      return Colors.grey;
  }
}

Widget buildStatusChip(String status, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  String localizedLabel;
  switch (status.toLowerCase()) {
    case "pending":
      localizedLabel = l10n.statusPending;
      break;
    case "confirmed":
      localizedLabel = l10n.statusConfirmed;
      break;
    case "ready_to_ship":
      localizedLabel = l10n.statusReadyToShip;
      break;
    case "shipped":
      localizedLabel = l10n.statusShipped;
      break;
    case "delivered":
      localizedLabel = l10n.statusDelivered;
      break;
    case "returned":
      localizedLabel = l10n.statusReturned;
      break;
    case "cancelled":
      localizedLabel = l10n.statusCancelled;
      break;
    default:
      localizedLabel = status;
  }

  return Chip(
    label: Text(localizedLabel),
    avatar: Icon(
      getStatusIcon(status),
      color: getStatusColor(status),
      size: 20,
    ),
    backgroundColor: AppColors.backGroundColor,
    side: BorderSide.none,
    labelStyle: TextStyle(color: getStatusColor(status)),
  );
}
