part of 'create_product_bloc.dart';

@immutable
sealed class CreateProductState {}

final class CreateProductInitial extends CreateProductState {}

final class CreateProductLoading extends CreateProductState {}

final class CreateProductLoaded extends CreateProductState {
  final ProductResponeModel productResponeModel;
  CreateProductLoaded({
    required this.productResponeModel,
  });
}
