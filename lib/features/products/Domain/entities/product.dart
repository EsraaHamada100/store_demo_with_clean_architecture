import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

// to create the .g.dart file you should run this command
// flutter packages pub run build_runner build
@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final String productId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final ProductCategory category;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final CreatedBy createdBy;
  @HiveField(6)
  final String createdAt;
  @HiveField(7)
  final String updatedAt;
  @HiveField(8)
  final String slug;
  @HiveField(9)
  final String? image;
  const Product({
    required this.productId,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.image,
  });

  @override
  List<Object?> get props => [
        productId,
        title,
        price,
        category,
        description,
        createdBy,
        createdAt,
        updatedAt,
        slug,
        image
      ];
}

@HiveType(typeId: 1)
class ProductCategory extends Equatable {
  @HiveField(0)
  final String categoryId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String slug;

  const ProductCategory({
    required this.categoryId,
    required this.name,
    required this.slug,
  });

  @override
  List<Object?> get props => [categoryId, name, slug];
}

@HiveType(typeId: 2)
class CreatedBy extends Equatable {
  @HiveField(0)
  final String role;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String name;

  const CreatedBy({
    required this.role,
    required this.userId,
    required this.name,
  });
  @override
  List<Object?> get props => [role, userId, name];
}
