import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/product_use_case.dart';
import '../event/product_event.dart';
import '../state/product_state.dart';


class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final GetProductsUsecase getProducts;

  int skip = 0;

  ProductsBloc(this.getProducts) : super(ProductsState.initial()) {

    on<LoadProducts>(_onLoadProducts);

  }

  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductsState> emit) async {

    if(state.hasReachedMax) return;

    emit(state.copyWith(loading: true));

    try{

      final newProducts = await getProducts(skip);

      skip += 10;

      emit(
        state.copyWith(
          products: [...state.products,...newProducts],
          loading: false,
          hasReachedMax: newProducts.isEmpty,
        ),
      );

    }catch(e){

      emit(state.copyWith(loading: false));

    }
  }

}