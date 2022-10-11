import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';

// Now Playing Movie
class NowPlayingMovieStateHelper extends Fake implements MovieState {}

class NowPlayingMovieEventHelper extends Fake implements MovieEvent {}

class NowPlayingMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements NowPlayingMovieBloc {}

// Popular Movie
class PopularMovieStateHelper extends Fake implements MovieState {}

class PopularMovieEventHelper extends Fake implements MovieEvent {}

class PopularMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements PopularMovieBloc {}

// Top Rated Movie
class TopRatedMovieStateHelper extends Fake implements MovieState {}

class TopRatedMovieEventHelper extends Fake implements MovieEvent {}

class TopRatedMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMovieBloc {}

// Detail Movie
class DetailMovieStateHelper extends Fake implements MovieState {}

class DetailMovieEventHelper extends Fake implements MovieEvent {}

class DetailMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements DetailMovieBloc {}

// Recommendations Movie
class RecommedationsMovieStateHelper extends Fake implements MovieState {}

class RecommedationsMovieEventHelper extends Fake implements MovieEvent {}

class RecommedationsMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements RecommendationsBloc {}

// Watch List Movie
class WatchlistMovieStateHelper extends Fake implements MovieState {}

class WatchlistMovieEventHelper extends Fake implements MovieEvent {}

class WatchlistMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements WatchlistMovieBloc {}
