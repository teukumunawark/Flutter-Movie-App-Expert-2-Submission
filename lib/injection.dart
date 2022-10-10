import 'package:module_movies/data/datasources/db/database_helper.dart';
import 'package:module_movies/data/datasources/movie_local_data_source.dart';
import 'package:module_movies/data/datasources/movie_remote_data_source.dart';
import 'package:module_movies/data/repositories/movie_repository_impl.dart';
import 'package:module_movies/domain/repositories/movie_repository.dart';
import 'package:module_movies/domain/usecases/get_movie_detail.dart';
import 'package:module_movies/domain/usecases/get_movie_recommendations.dart';
import 'package:module_movies/domain/usecases/get_now_playing_movies.dart';
import 'package:module_movies/domain/usecases/get_popular_movies.dart';
import 'package:module_movies/domain/usecases/get_top_rated_movies.dart';
import 'package:module_movies/domain/usecases/get_watchlist_movies.dart';
import 'package:module_movies/domain/usecases/get_watchlist_status.dart';
import 'package:module_movies/domain/usecases/remove_watchlist.dart';
import 'package:module_movies/domain/usecases/save_watchlist.dart';
import 'package:module_movies/domain/usecases/search_movies.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';
import 'package:module_tvseries/data/datasources/db/database_helper.dart';
import 'package:module_tvseries/data/datasources/tv_series_local_data_source.dart';
import 'package:module_tvseries/data/datasources/tv_series_remote_data_source.dart';
import 'package:module_tvseries/data/repositories/tv_series_repository_impl.dart';
import 'package:module_tvseries/domain/repositories/tv_series_repository.dart';
import 'package:module_tvseries/domain/usecases/get_on_the_air_tv.dart';
import 'package:module_tvseries/domain/usecases/get_popular_tv_series.dart';
import 'package:module_tvseries/domain/usecases/get_recommendations.dart';
import 'package:module_tvseries/domain/usecases/get_top_rated_tv.dart';
import 'package:module_tvseries/domain/usecases/get_tv_series_detail.dart';
import 'package:module_tvseries/domain/usecases/get_watchlist_status.dart';
import 'package:module_tvseries/domain/usecases/get_watchlist_tv_series.dart';
import 'package:module_tvseries/domain/usecases/remove_watchlist.dart';
import 'package:module_tvseries/domain/usecases/save_watchlist.dart';
import 'package:module_tvseries/domain/usecases/search_tv_series.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // BLOC
  // Movie BLOC
  locator.registerFactory(() => NowPlayingMovieBloc(
        locator(),
      ));
  locator.registerFactory(() => PopularMovieBloc(
        locator(),
      ));
  locator.registerFactory(() => TopRatedMovieBloc(
        locator(),
      ));
  locator.registerFactory(() => SearchMovieBloc(
        locator(),
      ));
  locator.registerFactory(() => RecommendationsBloc(
        locator(),
      ));
  locator.registerFactory(() => DetailMovieBloc(
        locator(),
      ));
  locator.registerFactory(() => WatchlistMovieBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // Tv series BLOC
  locator.registerFactory(() => OnTheAirTvSeriesBloc(
        locator(),
      ));
  locator.registerFactory(() => PopularTvSeriesBloc(
        locator(),
      ));
  locator.registerFactory(() => TopRatedTvSeriesBloc(
        locator(),
      ));
  locator.registerFactory(() => SearchTvSeriesBloc(
        locator(),
      ));
  locator.registerFactory(() => RecommendationsTvBloc(
        locator(),
      ));
  locator.registerFactory(() => DetailTvSeriesBloc(
        locator(),
      ));
  locator.registerFactory(() => WatchlistTvSeriesBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // USE CASE
  // Movie use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // Tv series use case
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  // repository
  // Movie repository
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ));
  // Tv repository
  locator
      .registerLazySingleton<TvSeriesRepository>(() => TvSeriesRepositoryImpl(
            remoteDataSource: locator(),
            localDataSource: locator(),
          ));
  // data sources
  // Movie data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(
            client: locator(),
          ));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(
            databaseHelper: locator(),
          ));
  // Tv Series data sources
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(
            client: locator(),
          ));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(
            databaseHelper: locator(),
          ));

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(
    () => MovieDatabaseHelper(),
  );
  locator.registerLazySingleton<TvSeriesDatabaseHelper>(
    () => TvSeriesDatabaseHelper(),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
