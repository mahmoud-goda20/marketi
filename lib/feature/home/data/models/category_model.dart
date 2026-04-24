import 'package:marketi/feature/home/domain/entitiy/category_entity.dart';

class CategoriesResponse {
  final List<CategoryModel> list;

  CategoriesResponse({
    required this.list,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      list: (json['list'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((e) => e.toJson()).toList(),
    };
  }

  CategoriesEntity toEntity() {
    return CategoriesEntity(
      list: list.map((e) => e.toEntity()).toList(),
    );
  }
}

class CategoryModel {
  final String slug;
  final String name;
  final String url;
  final String image;

  CategoryModel({
    required this.slug,
    required this.name,
    required this.url,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
      'image': image,
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      slug: slug,
      name: name,
      url: url,
      image: image,
    );
  }
}
