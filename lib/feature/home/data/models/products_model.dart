import 'package:marketi/feature/home/domain/entitiy/products_entity.dart';

class ProductsResponse {
  final List<ProductModel> list;
  final int total;
  final int skip;
  final int limit;

  ProductsResponse({
    required this.list,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    final items = json['list'] as List<dynamic>?;
    return ProductsResponse(
      list: items != null
          ? items
                .map(
                  (item) => ProductModel.fromJson(item as Map<String, dynamic>),
                )
                .toList()
          : [],
      total: json['total'] as int? ?? 0,
      skip: json['skip'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((item) => item.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }

  ProductsEntity toEntity() {
    return ProductsEntity(
      list: list.map((product) => product.toEntity()).toList(),
      total: total,
      skip: skip,
      limit: limit,
    );
  }
}

class ProductModel {
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
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      brand: json['brand'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      weight: json['weight'] as int? ?? 0,
      dimensions: Dimensions.fromJson(
        json['dimensions'] as Map<String, dynamic>? ?? {},
      ),
      warrantyInformation: json['warrantyInformation'] as String? ?? '',
      shippingInformation: json['shippingInformation'] as String? ?? '',
      availabilityStatus: json['availabilityStatus'] as String? ?? '',
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((item) => Review.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy'] as String? ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] as int? ?? 0,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>? ?? {}),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      sku: sku,
      weight: weight,
      dimensions: dimensions.toEntity(),
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      reviews: reviews.map((review) => review.toEntity()).toList(),
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      meta: meta.toEntity(),
      images: images,
      thumbnail: thumbnail,
    );
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({required this.width, required this.height, required this.depth});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      depth: (json['depth'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'depth': depth};
  }

  DimensionsEntity toEntity() {
    return DimensionsEntity(width: width, height: height, depth: depth);
  }
}

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      reviewerName: json['reviewerName'] as String? ?? '',
      reviewerEmail: json['reviewerEmail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      rating: rating,
      comment: comment,
      date: date,
      reviewerName: reviewerName,
      reviewerEmail: reviewerEmail,
    );
  }
}

class Meta {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
      barcode: json['barcode'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }

  MetaEntity toEntity() {
    return MetaEntity(
      createdAt: createdAt,
      updatedAt: updatedAt,
      barcode: barcode,
      qrCode: qrCode,
    );
  }
}
