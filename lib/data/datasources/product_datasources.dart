import 'dart:convert';

import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDatasources {
  Future<ProductResponeModel> createProduct(ProductModel model) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
      headers: {'Content-Type': 'application/json'},
      body: model.toJson(),
    );
    print('======');
    print(response.body);
    return ProductResponeModel.fromJson(response.body);
  }

  Future<ProductResponeModel> updateProduct(ProductModel model, int id) async {
    final response = await http.put(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
      body: model.toMap(),
    );

    return ProductResponeModel.fromJson(response.body);
  }

  Future<ProductResponeModel> getProductById(int id) async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
    );

    return ProductResponeModel.fromJson(response.body);
  }

  Future<List<ProductResponeModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
    );

    final result = List<ProductResponeModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponeModel.fromMap(x))).toList();

    return result;
  }
}
