part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

// Movie State Empty
class MovieEmpty extends MovieState {}

// Movie State Loading
class MovieLoading extends MovieState {}

// Movie State Error
class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

// Movie State HasData
class MovieHasData extends MovieState {
  final List<Movie> movies;

  const MovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

// Movie Detail State HasData
class MovieDetailHasData extends MovieState {
  final MovieDetail movieDetail;

  const MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

// Movie Search
class SearchHasData extends MovieState {
  final List<Movie> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

// Watchlist Movie HasData
class WatchlistHasData extends MovieState {
  final List<Movie> watchlist;

  const WatchlistHasData(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

// Watchlist Movie Message
class WatchlistMessage extends MovieState {
  final String message;

  const WatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

// Load Watchlist Movie Data
class LoadWatchlistData extends MovieState {
  final bool isWatchlist;

  const LoadWatchlistData(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}
