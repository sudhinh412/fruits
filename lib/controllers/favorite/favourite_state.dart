import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final Set<num> favoriteIds;

  const FavoriteState({this.favoriteIds = const {}});

  bool isFavorite(num? id) => favoriteIds.contains(id);

  FavoriteState copyWith({
    Set<num>? favoriteIds,
  }) {
    return FavoriteState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props => [favoriteIds];
}
