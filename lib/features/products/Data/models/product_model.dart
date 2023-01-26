import '../../Domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String productId,
    required String title,
    required int price,
    required ProductCategoryModel category,
    required String description,
    required CreatedByModel createdBy,
    required String createdAt,
    required String updatedAt,
    required String slug,
    required String? image,
  }) : super(
          productId: productId,
          title: title,
          price: price,
          category: category,
          description: description,
          createdBy: createdBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          slug: slug,
          image: image,
        );
  // from json
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['_id'],
      title: json['title'],
      price: json['price'],
      category: ProductCategoryModel.fromJson(json['category']),
      description: json['description'] == null ||
              json['description'].toString().trim() == ""
          ? ""
          : json['description'],
      createdBy: CreatedByModel.fromJson(json['createdBy']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      slug: json['slug'],
      image: json['image'].toString().trim() == "" ? null : json['image'],
    );
  }
  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = productId;
    data['title'] = title;
    data['price'] = price;
    data['category'] = (category as ProductCategoryModel).toJson();
    if (data['description'] != null) {
      data['description'] = description;
    }
    data['createdBy'] = (createdBy as CreatedByModel).toJson();
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['slug'] = slug;
    if (data['image'] != null) data['image'] = image;
    return data;
  }
}

class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel({
    required String categoryId,
    required String name,
    required String slug,
  }) : super(categoryId: categoryId, name: name, slug: slug);

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      categoryId: json['_id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = categoryId;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class CreatedByModel extends CreatedBy {
  const CreatedByModel({
    required String role,
    required String userId,
    required String name,
  }) : super(role: role, userId: userId, name: name);

  factory CreatedByModel.fromJson(Map<String, dynamic> json) {
    return CreatedByModel(
      role: json['role'],
      userId: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['_id'] = userId;
    data['name'] = name;
    return data;
  }
}
