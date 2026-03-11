import 'package:dio/dio.dart';
import '../model/product_model.dart';

class ProductsRemoteDatasource {

  final Dio dio;

  ProductsRemoteDatasource(this.dio);

  Future<List<ProductModel>> getProducts(int skip) async {

    final response = await dio.get(
      "https://dummyjson.com/products",
      queryParameters: {
        "limit": 10,
        "skip": skip,
      },
    );

    final List data = response.data["products"];

    return data.map((e)=>ProductModel.fromJson(e)).toList();
  }

}