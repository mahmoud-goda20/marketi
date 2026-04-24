import 'package:marketi/feature/home/domain/entitiy/products_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;

  CartEntity({required this.items});

  int get totalItems => items.length;

  int get totalQuantity => items.fold<int>(0, (sum, i) => sum + i.quantity);

  double get totalPrice =>
      items.fold<double>(0.0, (sum, i) => sum + (i.product.price * i.quantity));

  CartEntity copyWith({List<CartItemEntity>? items}) {
    return CartEntity(items: items ?? this.items);
  }
}

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  CartItemEntity({required this.product, required this.quantity});

  CartItemEntity copyWith({ProductEntity? product, int? quantity}) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
