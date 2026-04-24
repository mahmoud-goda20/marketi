import 'package:marketi/feature/home/domain/entitiy/products_entity.dart';

class FavoriteEntity {
  final List<FavoriteItemEntity> items;

  FavoriteEntity({required this.items});

  int get totalItems => items.length;

  int get totalQuantity => items.fold<int>(0, (sum, i) => sum + i.quantity);

  double get totalPrice =>
      items.fold<double>(0.0, (sum, i) => sum + (i.product.price * i.quantity));

  FavoriteEntity copyWith({List<FavoriteItemEntity>? items}) {
    return FavoriteEntity(items: items ?? this.items);
  }
}

class FavoriteItemEntity {
  final ProductEntity product;
  final int quantity;

  FavoriteItemEntity({required this.product, required this.quantity});

  FavoriteItemEntity copyWith({ProductEntity? product, int? quantity}) {
    return FavoriteItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
