part of 'fruits_bloc.dart';

 class FruitsState extends Equatable {
  const FruitsState();

  @override
  List<Object?> get props => [];
}

final class FruitsInitial extends FruitsState {
  @override
  List<Object> get props => [];
}

final class FruitsLoading extends FruitsState {
  @override
  List<Object> get props => [];
}

final class FruitsLoaded extends FruitsState {
  final List<Fruits> fruits;

  const FruitsLoaded(this.fruits);

  @override
  List<Object?> get props => [fruits];
}

final class FruitsError extends FruitsState {
  final String errmsg;

  const FruitsError(this.errmsg);

  @override
  List<Object?> get props => [errmsg];
}
