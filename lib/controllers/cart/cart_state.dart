import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final Map<num, int> items; // Map of fruit ID to quantity

  const CartState({this.items = const {}});

  int getCount(num? id) => items[id] ?? 0;

  CartState copyWith({
    Map<num, int>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [items];
}