class ProductsEntity {
  final List<ProductEntity> list;
  final int total;
  final int skip;
  final int limit;

  ProductsEntity({
    required this.list,
    required this.total,
    required this.skip,
    required this.limit,
  });
}

class ProductEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final DimensionsEntity dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewEntity> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final MetaEntity meta;
  final List<String> images;
  final String thumbnail;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });
}

class DimensionsEntity {
  final double width;
  final double height;
  final double depth;

  DimensionsEntity({
    required this.width,
    required this.height,
    required this.depth,
  });
}

class ReviewEntity {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
}

class MetaEntity {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  MetaEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });
}
