part of 'tv_series_bloc.dart';

abstract class TvSeriesState extends Equatable {
  const TvSeriesState();

  @override
  List<Object> get props => [];
}

// TV Series State Empty
class TvSeriesEmpty extends TvSeriesState {}

// TV Series State Loading
class TvSeriesLoading extends TvSeriesState {}

// TV Series State Error
class TvSeriesError extends TvSeriesState {
  final String message;

  const TvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

// TV Series State HasData
class TvSeriesHasData extends TvSeriesState {
  final List<TvSeries> tvseries;

  const TvSeriesHasData(this.tvseries);

  @override
  List<Object> get props => [tvseries];
}

// TV Series Detail State HasData
class TvSeriesDetailHasData extends TvSeriesState {
  final TvSeriesDetail tvSeriesDetail;

  const TvSeriesDetailHasData(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

// TV Series Search State
class TvSeriesSearchHasData extends TvSeriesState {
  final List<TvSeries> result;

  const TvSeriesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

// TV Series Watchlist HasData
class TvSeriesWatchlistHasData extends TvSeriesState {
  final List<TvSeries> watchlist;

  const TvSeriesWatchlistHasData(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

// TV Series Watchlist Message
class TvSeriesWatchlistMessage extends TvSeriesState {
  final String message;

  const TvSeriesWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

// TV Series Load Data Watchlist
class TvSeriesWatchlistLoadData extends TvSeriesState {
  final bool isWatchlist;

  const TvSeriesWatchlistLoadData(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}
