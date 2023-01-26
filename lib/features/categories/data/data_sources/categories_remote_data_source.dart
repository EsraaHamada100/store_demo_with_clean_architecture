import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../../../core/strings/failure_strings.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/strings/remote_data_source.dart';
import '../models/category.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> getSingleCategory(String categorySlug);
  Future<Unit> addCategory(CategoryModel categoryModel);
  Future<Unit> updateCategory(
    CategoryModel categoryModel,
    String categorySlugBeforeUpdate,
  );
  Future<Unit> deleteCategory(String categorySlug);
}

typedef RequestFunction = Future<Response> Function();

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final http.Client client;
  CategoriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    Response response =
        await tryRequest(() => client.get(Uri.parse('$BASE_URL/categories')));
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        List<CategoryModel> categoriesModels = decodedJson["data"]
            .map<CategoryModel>(
              (categoryJson) => CategoryModel.fromJson(categoryJson),
            )
            .toList();
        return categoriesModels;
      case 404:
        throw NotFoundException(CATEGORY_NOT_FOUND_MESSAGE);
      default:
        throw UnknownException();
    }
  }

  @override
  Future<CategoryModel> getSingleCategory(String categorySlug) async {
    Response response = await tryRequest(() => client
        .get(Uri.parse('$BASE_URL/categories/$categorySlug'), headers: header));
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        final CategoryModel categoryModel =
            CategoryModel.fromJson(decodedJson['data']);
        return categoryModel;
      case 404:
        throw NotFoundException(getErrorMessage(response.body));
      default:
        throw UnknownException();
    }
  }

  @override
  Future<Unit> addCategory(CategoryModel categoryModel) async {
    Response response = await tryRequest(() => client
        .post(Uri.parse('$BASE_URL/categories'), body: categoryModel.toJson()));
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteCategory(String categorySlug) async {
    Response response = await tryRequest(
        () => client.delete(Uri.parse('$BASE_URL/categories/categorySlug')));
    switch (response.statusCode) {
      case 200:
        return Future.value(unit);
      case 404:
        throw NotFoundException(getErrorMessage(response.body));
      default:
        throw UnknownException();
    }
  }

  @override
  Future<Unit> updateCategory(
      CategoryModel categoryModel, String categorySlugBeforeUpdate) async {
    Response response = await tryRequest(() => client
        .put(Uri.parse('$BASE_URL/categories/$categorySlugBeforeUpdate')));
    switch (response.statusCode) {
      case 201:
        return Future.value(unit);
      case 406:
        throw NotFoundException(getErrorMessage(response.body));
      default:
        throw ServerException();
    }
  }

  String getErrorMessage(String responseBody) {
    final Map<String, dynamic> decodedJson = jsonDecode(responseBody);
    String message = decodedJson['message'];
    return message;
  }

  Future<Response> tryRequest(
      RequestFunction getOrPostOrPutOrDeleteRequest) async {
    try {
      final Response response = await getOrPostOrPutOrDeleteRequest();
      return response;
    } on SocketException {
      throw NoInternetException();
    } on Exception {
      throw UnknownException();
    }
  }
}
