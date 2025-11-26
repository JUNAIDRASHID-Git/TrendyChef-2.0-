import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

Future<CartItemModel> addItemToGuestCart({
  required String guestId,
  required int productId,
  required int quantity,
}) async {
  final url = Uri.parse('$baseHost/guest/cart?guest_id=$guestId');

  final Map<String, dynamic> bodyMap = {
    'product_id': productId.toString(),
    'quantity': quantity,
  };

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(bodyMap),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    return CartItemModel.fromJson(decoded);
  } else if (response.statusCode == 400) {
    throw Exception('Bad request: ${response.body}');
  } else {
    throw Exception(
      'Failed to add item: ${response.statusCode} ${response.body}',
    );
  }
}
