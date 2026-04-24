import 'package:marketi/feature/home/domain/entitiy/brand_entity.dart';

class BrandsResponse {
  final List<BrandModel> list;

  BrandsResponse({required this.list});

  factory BrandsResponse.fromJson(Map<String, dynamic> json) {
    final items = json['list'] as List<dynamic>?;
    return BrandsResponse(
      list: items != null
          ? items
                .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'list': list.map((e) => e.toJson()).toList()};
  }

  BrandsEntity toEntity() {
    return BrandsEntity(list: list.map((e) => e.toEntity()).toList());
  }
}

class BrandModel {
  final String name;
  final String emoji;

  BrandModel({required this.name, required this.emoji});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'emoji': emoji};
  }

  BrandEntity toEntity() {
    return BrandEntity(name: name, emoji: emoji);
  }
}
