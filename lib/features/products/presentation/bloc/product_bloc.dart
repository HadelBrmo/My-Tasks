import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/features/products/domain/usecases/GetProductsUseCase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase}) : super(ProductInitial()) {

    on<GetProductsEvent>((event, emit) async {

      emit(ProductLoading());

      final result = await getProductsUseCase();

      result.fold(
        (failure) => emit(ProductError(message: failure.message)),
        (products) => emit(ProductLoaded(products: products)),
      );
    });


  }
}