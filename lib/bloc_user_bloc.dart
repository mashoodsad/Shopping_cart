import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'Product.dart';
import 'api_repo.dart';

part 'bloc_user_event.dart';
part 'bloc_user_state.dart';

class UserBloc extends Bloc<ProductEvent, ProductState> {
  UserBloc() : super(ProductInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<ProductEvent>((event, emit) async {
      try{
        emit(ProductLoading());
        final plist = await apiRepository.fetchProductList();
        emit(ProductLoaded(plist));
        if (plist.error != null) {
          emit(ProductError(plist.error));
        }
      } on NetworkError {
        emit(const ProductError("Failed to fetch data. is your device online?"));
      }
      }
    );
  }
}
