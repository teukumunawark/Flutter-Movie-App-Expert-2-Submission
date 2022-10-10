part of 'tv_series_bloc.dart';

abstract class TvSeriesEvent extends Equatable {
  const TvSeriesEvent();

  @override
  List<Object> get props => [];
}

// On The Air Event
class OnTvSeriesTheAir extends TvSeriesEvent {}

// Popular Event
class OnPopularTvSeries extends TvSeriesEvent {}

// Top Rated Event
class OnTopRatedTvSeries extends TvSeriesEvent {}

// Search Event
class OnQueryChangedTvSeries extends TvSeriesEvent {
  final String query;

  const OnQueryChangedTvSeries(this.query);

  @override
  List<Object> get props => [query];
}

// Recommendation Event
class OnRecommendationTvSeries extends TvSeriesEvent {
  final int id;

  const OnRecommendationTvSeries(this.id);

  @override
  List<Object> get props => [id];
}

// Detail Event
class OnDetailTvSeries extends TvSeriesEvent {
  final int id;

  const OnDetailTvSeries(this.id);

  @override
  List<Object> get props => [id];
}

// Watchlist Event
class OnWatchlistTvSeries extends TvSeriesEvent {}

// Save Watchlist tvseries Event
class OnSaveWatchlistTvSeries extends TvSeriesEvent {
  final TvSeriesDetail tvseries;

  const OnSaveWatchlistTvSeries(this.tvseries);

  @override
  List<Object> get props => [tvseries];
}

// Remove Watchlist tvseries Event
class OnRemoveWatchlistTvSeries extends TvSeriesEvent {
  final TvSeriesDetail tvseries;

  const OnRemoveWatchlistTvSeries(this.tvseries);

  @override
  List<Object> get props => [tvseries];
}

// Load Watchlist tvseries Event
class OnLoadWatchlistStatusTvSeries extends TvSeriesEvent {
  final int id;

  const OnLoadWatchlistStatusTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
