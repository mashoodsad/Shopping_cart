part of 'bloc_user_bloc.dart';



abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductList extends ProductEvent {}