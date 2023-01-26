import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required id,
    required name,
    required slug,
    required productsId,
  }) : super(
          id: id,
          name: name,
          slug: slug,
          productsId: productsId,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      productsId: json['products'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug, 
      'products': productsId
    };
  }
}
