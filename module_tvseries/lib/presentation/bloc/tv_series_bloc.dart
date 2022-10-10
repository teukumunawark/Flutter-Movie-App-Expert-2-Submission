import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../../domain/usecases/get_on_the_air_tv.dart';
import '../../domain/usecases/get_popular_tv_series.dart';
import '../../domain/usecases/get_recommendations.dart';
import '../../domain/usecases/get_top_rated_tv.dart';
import '../../domain/usecases/get_tv_series_detail.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/get_watchlist_tv_series.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';
import '../../domain/usecases/search_tv_series.dart';

part 'tv_series_event.dart';
part 'tv_series_state.dart';

// TV Series On The Air Bloc
class OnTheAirTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetOnTheAirTvSeries _onTheAirTvSeries;
  OnTheAirTvSeriesBloc(this._onTheAirTvSeries) : super(TvSeriesLoading()) {
    on<OnTvSeriesTheAir>((event, emit) async {
      emit(TvSeriesLoading());
      final result = await _onTheAirTvSeries.execute();
      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(TvSeriesHasData(data)),
      );
    });
  }
}

// TV Series Popular Bloc
class PopularTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetPopularTvSeries _popularTvSeries;
  PopularTvSeriesBloc(this._popularTvSeries) : super(TvSeriesLoading()) {
    on<OnPopularTvSeries>((event, emit) async {
      emit(TvSeriesLoading());
      final result = await _popularTvSeries.execute();
      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(TvSeriesHasData(data)),
      );
    });
  }
}

// TV Series Top Rated Bloc
class TopRatedTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTopRatedTvSeries _topRatedTvSeries;

  TopRatedTvSeriesBloc(this._topRatedTvSeries) : super(TvSeriesLoading()) {
    on<OnTopRatedTvSeries>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _topRatedTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(TvSeriesHasData(data)),
      );
    });
  }
}

// Search TV Series Bloc
class SearchTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchTvSeriesBloc(this._searchTvSeries) : super(TvSeriesLoading()) {
    on<OnQueryChangedTvSeries>(
      (event, emit) async {
        final query = event.query;
        emit(TvSeriesLoading());
        final result = await _searchTvSeries.execute(query);
        result.fold(
          (failure) => emit(TvSeriesError(failure.message)),
          (data) => emit(TvSeriesSearchHasData(data)),
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

// Recommendation Tv Series Bloc
class RecommendationsTvBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesRecommendations _tvSeriesRecommendations;

  RecommendationsTvBloc(this._tvSeriesRecommendations)
      : super(TvSeriesLoading()) {
    on<OnRecommendationTvSeries>((event, emit) async {
      final int id = event.id;
      emit(TvSeriesLoading());
      final result = await _tvSeriesRecommendations.execute(id);

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(TvSeriesHasData(data)),
      );
    });
  }
}

// Detail Tv Series Bloc
class DetailTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesDetail _tvSeriesDetail;

  DetailTvSeriesBloc(this._tvSeriesDetail) : super(TvSeriesLoading()) {
    on<OnDetailTvSeries>((event, emit) async {
      final int id = event.id;

      emit(TvSeriesLoading());

      final result = await _tvSeriesDetail.execute(id);

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(TvSeriesDetailHasData(data)),
      );
    });
  }
}

// Watchlist Tv Series Bloc
class WatchlistTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetWatchlistTvSeries _watchlistTvSeries;
  final GetWatchListStatusTvSeries _watchListStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  static const messageAddedToWatchlist = "Added to Watchlist";
  static const messageRemoveToWatchlist = "Removed from Watchlist";

  WatchlistTvSeriesBloc(
    this._watchlistTvSeries,
    this._watchListStatusTvSeries,
    this._saveWatchlistTvSeries,
    this._removeWatchlistTvSeries,
  ) : super(TvSeriesEmpty()) {
    // Watchlist TV Series
    on<OnWatchlistTvSeries>((event, emit) async {
      emit(TvSeriesLoading());
      final result = await _watchlistTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(TvSeriesWatchlistHasData(data)),
      );
    });

    // Wacthlist Status Tv Series
    on<OnLoadWatchlistStatusTvSeries>((event, emit) async {
      final int id = event.id;

      emit(TvSeriesLoading());

      final result = await _watchListStatusTvSeries.execute(id);
      emit(TvSeriesWatchlistLoadData(result));
    });

    // Save Watchlist Tv Series
    on<OnSaveWatchlistTvSeries>((event, emit) async {
      final tvseries = event.tvseries;
      emit(TvSeriesLoading());

      final result = await _saveWatchlistTvSeries.execute(tvseries);

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (message) => emit(TvSeriesWatchlistMessage(message)),
      );
    });

    on<OnRemoveWatchlistTvSeries>((event, emit) async {
      final tvseries = event.tvseries;

      emit(TvSeriesLoading());

      final result = await _removeWatchlistTvSeries.execute(tvseries);

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (message) => emit(TvSeriesWatchlistMessage(message)),
      );
    });
  }
}
