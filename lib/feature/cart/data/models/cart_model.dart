import 'package:marketi/feature/cart/domain/entity/cart_entity.dart';
import 'package:marketi/feature/home/data/models/products_model.dart';

/// Data model for a single cart item: product + quantity
class CartItemModel {
  final ProductModel product;
  final int quantity;

  CartItemModel({required this.product, required this.quantity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('product')) {
      final productJson = json['product'] as Map<String, dynamic>? ?? {};
      return CartItemModel(
        product: ProductModel.fromJson(productJson),
        quantity: (json['quantity'] as int?) ?? 1,
      );
    }

    // If the JSON is a direct product object (no wrapper), treat quantity as 1 or as provided
    return CartItemModel(
      product: ProductModel.fromJson(json),
      quantity: (json['quantity'] as int?) ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }
}

/// Cart response containing a list of cart items.
/// Accepts either `list` or `items` keys in JSON.
class CartResponse {
  final List<CartItemModel> items;

  CartResponse({required this.items});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['list'] ?? json['items'] ?? [];
    final parsed = <CartItemModel>[];

    if (raw is List) {
      for (final el in raw) {
        if (el is Map<String, dynamic>) {
          parsed.add(CartItemModel.fromJson(el));
        }
      }
    }

    return CartResponse(items: parsed);
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((i) => i.toJson()).toList()};
  }

  CartEntity toEntity() {
    return CartEntity(
      items: items
          .map(
            (i) => CartItemEntity(
              product: i.product.toEntity(),
              quantity: i.quantity,
            ),
          )
          .toList(),
    );
  }
}
