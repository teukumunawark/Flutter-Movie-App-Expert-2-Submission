import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';
import 'package:module_tvseries/presentation/pages/tv_series_detail_page.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_bloc_helper.dart';

void main() {
  late RecommendationsTvBlocHelper recommendationsTvBlocHelper;
  late DetailTvBlocHelper detailTvBlocHelper;
  late WatchlistTvBlocHelper watchlistTvBlocHelper;

  setUpAll(() {
    // Recommendation TV Series
    registerFallbackValue(RecommendationsTvStateHelper());
    registerFallbackValue(RecommendationsTvEventHelper());
    recommendationsTvBlocHelper = RecommendationsTvBlocHelper();

    // Detail TV Series
    registerFallbackValue(DetailTvStateHelper());
    registerFallbackValue(DetailTvEventHelper());
    detailTvBlocHelper = DetailTvBlocHelper();

    // WatchList TV Series
    registerFallbackValue(WatchlistTvStateHelper());
    registerFallbackValue(WatchlistTvEventHelper());
    watchlistTvBlocHelper = WatchlistTvBlocHelper();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<RecommendationsTvBloc>(
          create: (_) => recommendationsTvBlocHelper,
        ),
        BlocProvider<DetailTvSeriesBloc>(
          create: (_) => detailTvBlocHelper,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (_) => watchlistTvBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    ((WidgetTester widgetTester) async {
      when(() => detailTvBlocHelper.state).thenReturn(TvSeriesLoading());
      when(() => recommendationsTvBlocHelper.state)
          .thenReturn(TvSeriesLoading());
      when(() => watchlistTvBlocHelper.state).thenReturn(TvSeriesLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(
        _makeTestableWidget(
          const TvSeriesDetailPage(
            id: 1,
          ),
        ),
      );

      await widgetTester.pump();

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Watchlist button should display add icon when tv added to watch list',
    ((WidgetTester widgetTester) async {
      when(() => detailTvBlocHelper.state).thenReturn(
        TvSeriesDetailHasData(testTvSeriesDetail),
      );
      when(() => recommendationsTvBlocHelper.state).thenReturn(
        TvSeriesDetailHasData(testTvSeriesDetail),
      );
      when(() => watchlistTvBlocHelper.state).thenReturn(
        const TvSeriesWatchlistLoadData(false),
      );

      final watchListButtonIcon = find.byIcon(Icons.add);

      await widgetTester.pumpWidget(
        _makeTestableWidget(
          const TvSeriesDetailPage(
            id: 1,
          ),
        ),
      );

      await widgetTester.pump();

      expect(watchListButtonIcon, findsOneWidget);
    }),
  );

  testWidgets(
    'Watchlist button should display check icon when movie added to watch list',
    ((WidgetTester widgetTester) async {
      when(() => detailTvBlocHelper.state).thenReturn(
        TvSeriesDetailHasData(testTvSeriesDetail),
      );
      when(() => recommendationsTvBlocHelper.state).thenReturn(
        TvSeriesDetailHasData(testTvSeriesDetail),
      );
      when(() => watchlistTvBlocHelper.state).thenReturn(
        const TvSeriesWatchlistLoadData(true),
      );

      final watchListButtonIcon = find.byIcon(Icons.check);

      await widgetTester.pumpWidget(
        _makeTestableWidget(
          const TvSeriesDetailPage(
            id: 1,
          ),
        ),
      );

      await widgetTester.pump();

      expect(watchListButtonIcon, findsOneWidget);
    }),
  );
}
