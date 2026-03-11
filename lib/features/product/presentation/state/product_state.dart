import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

class ProductsState extends Equatable {

  final List<Product> products;
  final bool loading;
  final bool hasReachedMax;

  const ProductsState({
    required this.products,
    required this.loading,
    required this.hasReachedMax,
  });

  factory ProductsState.initial(){

    return const ProductsState(
      products: [],
      loading: false,
      hasReachedMax: false,
    );
  }

  ProductsState copyWith({
    List<Product>? products,
    bool? loading,
    bool? hasReachedMax,
  }){

    return ProductsState(
      products: products ?? this.products,
      loading: loading ?? this.loading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );

  }

  @override
  List<Object?> get props => [products,loading,hasReachedMax];

}