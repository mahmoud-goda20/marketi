class BrandsEntity {
  final List<BrandEntity> list;

  BrandsEntity({required this.list});
}

class BrandEntity {
  final String name;
  final String emoji;

  BrandEntity({required this.name, required this.emoji});
}
