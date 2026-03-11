import '../../domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';
import '../data_sources/product_remote_ds.dart';


class ProductsRepositoryImpl implements ProductsRepository {

  final ProductsRemoteDatasource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<List<Product>> getProducts(int skip) {

    return datasource.getProducts(skip);

  }

}