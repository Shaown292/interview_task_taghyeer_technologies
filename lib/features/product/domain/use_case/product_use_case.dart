import '../entities/product.dart';
import '../repository/product_repository.dart';

class GetProductsUsecase {

  final ProductsRepository repository;

  GetProductsUsecase(this.repository);

  Future<List<Product>> call(int skip){

    return repository.getProducts(skip);

  }

}