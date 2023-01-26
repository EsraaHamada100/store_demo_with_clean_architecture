import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';
@HiveType(typeId: 3)
class Category extends Equatable{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String slug;
  @HiveField(3)
  final List<String> productsId;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.productsId,
  });
  
  @override

  List<Object?> get props => [id, name, slug, productsId];
}

