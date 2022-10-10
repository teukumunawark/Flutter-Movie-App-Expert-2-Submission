part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

// Now Playing Movie Event
class OnNowPlayingMovie extends MovieEvent {}

// Popular Movie Event
class OnPopularMovie extends MovieEvent {}

// Top Rated Movie Event
class OnTopRatedMovie extends MovieEvent {}

// Detail Movie Event
class OnDetailMovie extends MovieEvent {
  final int id;

  const OnDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}

// Recommended Movie Event
class OnRecommendationMovie extends MovieEvent {
  final int id;

  const OnRecommendationMovie(this.id);

  @override
  List<Object> get props => [id];
}

// Search Movie Event
class OnQueryChanged extends MovieEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

// Watchlist Movie
class OnWatchlist extends MovieEvent {}

// Save Watchlist Movie Event
class OnSaveWatchlist extends MovieEvent {
  final MovieDetail movie;

  const OnSaveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

// Remove Watchlist Movie Event
class OnRemoveWatchlist extends MovieEvent {
  final MovieDetail movie;

  const OnRemoveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

// Load Watchlist Movie Event
class OnLoadWatchlistStatus extends MovieEvent {
  final int id;

  const OnLoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
