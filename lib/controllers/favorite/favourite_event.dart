import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class ToggleFavorite extends FavoriteEvent {
  final num productId;

  const ToggleFavorite(this.productId);

  @override
  List<Object?> get props => [productId];
}
