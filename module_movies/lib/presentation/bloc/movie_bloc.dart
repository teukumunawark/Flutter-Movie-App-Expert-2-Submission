import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_movie_recommendations.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import '../../domain/usecases/get_watchlist_movies.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';
import '../../domain/usecases/search_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

// Now Playing Movie
class NowPlayingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingMovieBloc(this._nowPlayingMovies) : super(MovieLoading()) {
    on<OnNowPlayingMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _nowPlayingMovies.execute();
      result.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (data) => emit(
          MovieHasData(data),
        ),
      );
    });
  }
}

// Popular Movie
class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _popularMovies;

  PopularMovieBloc(this._popularMovies) : super(MovieLoading()) {
    on<OnPopularMovie>((event, emit) async {
      emit(MovieLoading());

      final result = await _popularMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

// Top Reted Movie
class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _topRatedMovies;

  TopRatedMovieBloc(this._topRatedMovies) : super(MovieLoading()) {
    on<OnTopRatedMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _topRatedMovies.execute();
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

// Recommendations
class RecommendationsBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _movieRecommendations;

  RecommendationsBloc(this._movieRecommendations) : super(MovieLoading()) {
    on<OnRecommendationMovie>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());
      final result = await _movieRecommendations.execute(id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

// Search Movie
class SearchMovieBloc extends Bloc<MovieEvent, MovieState> {
  final SearchMovies _searchMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchMovieBloc(this._searchMovies) : super(MovieEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(MovieLoading());
      final result = await _searchMovies.execute(query);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(SearchHasData(data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

// Detail Movie
class DetailMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _movieDetail;

  DetailMovieBloc(this._movieDetail) : super(MovieLoading()) {
    on<OnDetailMovie>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());
      final result = await _movieDetail.execute(id);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieDetailHasData(data)),
      );
    });
  }
}

// Watchlist Movie
class WatchlistMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _watchlistMovies;
  final GetWatchListStatusMovie _watchListStatusMovie;
  final SaveWatchlistMovie _saveWatchlistMovie;
  final RemoveWatchlistMovie _removeWatchlistMovie;

  static const messageAddedToWatchlist = "Added to Watchlist";
  static const messageRemoveToWatchlist = "Removed from Watchlist";

  WatchlistMovieBloc(
    this._watchlistMovies,
    this._watchListStatusMovie,
    this._saveWatchlistMovie,
    this._removeWatchlistMovie,
  ) : super(MovieEmpty()) {
    // On Watchlist
    on<OnWatchlist>((event, emit) async {
      emit(MovieLoading());

      final result = await _watchlistMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(WatchlistHasData(data)),
      );
    });

    // On Load Status
    on<OnLoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());
      final result = await _watchListStatusMovie.execute(id);
      emit(LoadWatchlistData(result));
    });

    //  On Save Watchlist
    on<OnSaveWatchlist>((event, emit) async {
      final movie = event.movie;
      emit(MovieLoading());
      final result = await _saveWatchlistMovie.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (message) => emit(WatchlistMessage(message)),
      );
    });

    // On Remove Watchlist
    on<OnRemoveWatchlist>((event, emit) async {
      final movie = event.movie;
      emit(MovieLoading());
      final result = await _removeWatchlistMovie.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (message) => emit(WatchlistMessage(message)),
      );
    });
  }
}
