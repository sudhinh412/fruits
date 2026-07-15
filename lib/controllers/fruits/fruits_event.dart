part of 'fruits_bloc.dart';

sealed class FruitsEvent extends Equatable {
  const FruitsEvent();

  @override
  List<Object?> get props => [];
}

class LoadFruits extends FruitsEvent {}
