import 'package:bloc/bloc.dart';
import 'package:fruits/controllers/cart/cart_state.dart';
import 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddItem>((event, emit) {
      if (event.fruit.id == null) return;
      final newItems = Map<num, int>.from(state.items);
      newItems[event.fruit.id!] = 1;
      emit(state.copyWith(items: newItems));
    });

    on<IncrementItem>((event, emit) {
      final newItems = Map<num, int>.from(state.items);
      final currentQty = newItems[event.productId] ?? 0;
      newItems[event.productId] = currentQty + 1;
      emit(state.copyWith(items: newItems));
    });

    on<DecrementItem>((event, emit) {
      final newItems = Map<num, int>.from(state.items);
      final currentQty = newItems[event.productId] ?? 0;
      if (currentQty <= 1) {
        newItems.remove(event.productId);
      } else {
        newItems[event.productId] = currentQty - 1;
      }
      emit(state.copyWith(items: newItems));
    });
  }
}