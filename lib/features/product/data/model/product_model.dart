import '../../domain/entities/product.dart';

class ProductModel extends Product {

  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map<String,dynamic> json){

    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: (json["price"]).toDouble(),
      thumbnail: json["thumbnail"],
    );

  }

}