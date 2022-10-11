import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';

// On The Air TV Series
class OnTheAirTvStateHelper extends Fake implements TvSeriesState {}

class OnTheAirTvEventHelper extends Fake implements TvSeriesState {}

class OnTheAirTvBlocHelper extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements OnTheAirTvSeriesBloc {}

// Popular TV Series
class PopularTvStateHelper extends Fake implements TvSeriesState {}

class PopularTvEventHelper extends Fake implements TvSeriesState {}

class PopularTvBlocHelper extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements PopularTvSeriesBloc {}

// Top Rated TV Series
class TopRatedTvStateHelper extends Fake implements TvSeriesState {}

class TopRatedTvEventHelper extends Fake implements TvSeriesState {}

class TopRatedTvBlocHelper extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements TopRatedTvSeriesBloc {}

// Detail TV Series
class DetailTvStateHelper extends Fake implements TvSeriesState {}

class DetailTvEventHelper extends Fake implements TvSeriesState {}

class DetailTvBlocHelper extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements DetailTvSeriesBloc {}

// Recommendations TV Series
class RecommendationsTvStateHelper extends Fake implements TvSeriesState {}

class RecommendationsTvEventHelper extends Fake implements TvSeriesState {}

class RecommendationsTvBlocHelper extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements RecommendationsTvBloc {}

// Watch List TV Series
class WatchlistTvStateHelper extends Fake implements TvSeriesState {}

class WatchlistTvEventHelper extends Fake implements TvSeriesState {}

class WatchlistTvBlocHelper extends MockBloc<TvSeriesEvent, TvSeriesState>
    implements WatchlistTvSeriesBloc {}
