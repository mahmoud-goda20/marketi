import 'package:marketi/feature/favorite/domain/entity/favorite_entity.dart';
import 'package:marketi/feature/home/data/models/products_model.dart';

/// Data model for a single cart item: product + quantity
class FavoriteItemModel {
  final ProductModel product;
  final int quantity;

  FavoriteItemModel({required this.product, required this.quantity});

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('product')) {
      final productJson = json['product'] as Map<String, dynamic>? ?? {};
      return FavoriteItemModel(
        product: ProductModel.fromJson(productJson),
        quantity: (json['quantity'] as int?) ?? 1,
      );
    }

    // If the JSON is a direct product object (no wrapper), treat quantity as 1 or as provided
    return FavoriteItemModel(
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
class FavoriteResponse {
  final List<FavoriteItemModel> items;

  FavoriteResponse({required this.items});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['list'] ?? json['items'] ?? [];
    final parsed = <FavoriteItemModel>[];

    if (raw is List) {
      for (final el in raw) {
        if (el is Map<String, dynamic>) {
          parsed.add(FavoriteItemModel.fromJson(el));
        }
      }
    }

    return FavoriteResponse(items: parsed);
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((i) => i.toJson()).toList()};
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      items: items
          .map(
            (i) => FavoriteItemEntity(
              product: i.product.toEntity(),
              quantity: i.quantity,
            ),
          )
          .toList(),
    );
  }
}
