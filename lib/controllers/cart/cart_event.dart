import 'package:equatable/equatable.dart';
import '../../model/Fruits.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddItem extends CartEvent {
  final Fruits fruit;
  const AddItem(this.fruit);

  @override
  List<Object?> get props => [fruit];
}

class IncrementItem extends CartEvent {
  final num productId;
  const IncrementItem(this.productId);

  @override
  List<Object?> get props => [productId];
}

class DecrementItem extends CartEvent {
  final num productId;
  const DecrementItem(this.productId);

  @override
  List<Object?> get props => [productId];
}