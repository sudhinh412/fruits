import 'package:bloc/bloc.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState()) {
    on<ToggleFavorite>((event, emit) {
      final currentFavorites = Set<num>.from(state.favoriteIds);
      if (currentFavorites.contains(event.productId)) {
        currentFavorites.remove(event.productId);
      } else {
        currentFavorites.add(event.productId);
      }
      emit(state.copyWith(favoriteIds: currentFavorites));
    });
  }
}
