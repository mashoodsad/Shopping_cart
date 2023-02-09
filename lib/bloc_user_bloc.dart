import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'Product.dart';
import 'api_repo.dart';

part 'bloc_user_event.dart';
part 'bloc_user_state.dart';

class UserBloc extends Bloc<ProductEvent, ProductState> {
  UserBloc() : super(ProductInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<ProductEvent>((event, emit) async {
      try{
        emit(ProductLoading());
        final PList = await _apiRepository.fetchProductList();
        emit(ProductLoaded(PList));
        if (PList.error != null) {
          emit(ProductError(PList.error));
        }
      } on NetworkError {
        emit(const ProductError("Failed to fetch data. is your device online?"));
      }
      }
    );
  }
}
