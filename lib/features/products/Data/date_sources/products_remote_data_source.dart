import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import '../../../../core/strings/failure_strings.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/strings/remote_data_source.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getSingleProduct(String productSlug);
  Future<Unit> addProduct(ProductModel productModel);
  Future<Unit> updateProduct(
      ProductModel productModel, String productSlugBeforeUpdate);
  Future<Unit> deleteProduct(String productSlug);
}


typedef RequestFunction = Future<Response> Function();

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;
  ProductsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    Response response = await tryRequest(() => client.get(
          Uri.parse('$BASE_URL/products'),
          headers: header,
        ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      List<ProductModel> productModels = decodedJson['data']
          .map<ProductModel>(
              (jsonProduct) => ProductModel.fromJson(jsonProduct))
          .toList();
      return productModels;
    } else if (response.statusCode == 404) {
      throw NotFoundException(PRODUCT_NOT_FOUND_MESSAGE);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getSingleProduct(String productSlug) async {
    Response response = await tryRequest(() => client.get(
          Uri.parse('$BASE_URL/products/$productSlug'),
          headers: header,
        ));
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        ProductModel productModel = ProductModel.fromJson(decodedJson['data']);
        return productModel;
      case 404:
        throw NotFoundException(getErrorMessage(response.body));
      default:
        throw ServerException();
    }
  }

  @override
  Future<Unit> addProduct(ProductModel productModel) async {
    Response response = await tryRequest(() => client.post(
          Uri.parse('$BASE_URL/products'),
          body: getBody(productModel),
        ));
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(String productSlug) async {
    Response response = await tryRequest(
        () => client.delete(Uri.parse('$BASE_URL/products/$productSlug')));
    switch (response.statusCode) {
      case 200:
        return Future.value(unit);
      case 404:
        throw NotFoundException(getErrorMessage(response.body));
      default:
        throw ServerException();
    }
  }

  @override
  Future<Unit> updateProduct(
      ProductModel productModel, String productSlugBeforeUpdate) async {
    Response response = await tryRequest(() => client.put(
          Uri.parse('$BASE_URL/products/$productSlugBeforeUpdate'),
          body: getBody(productModel),
        ));
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

  Map<String, dynamic> getBody(ProductModel productModel) {
    final body = <String, dynamic>{
      "title": productModel.title,
      "price": productModel.price,
      "description": productModel.description,
      "category": productModel.category
    };
    return body;
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
