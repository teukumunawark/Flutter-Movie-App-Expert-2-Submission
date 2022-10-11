import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';
import 'package:module_movies/presentation/pages/movie_detail_page.dart';
import 'package:provider/provider.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_movie_bloc_helper.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late DetailMovieBlocHelper detailMovieBlocHelper;
  late RecommedationsMovieBlocHelper recommedationsMovieBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUpAll(() {
    // Recommendation Movie
    registerFallbackValue(RecommedationsMovieStateHelper());
    registerFallbackValue(RecommedationsMovieEventHelper());
    recommedationsMovieBlocHelper = RecommedationsMovieBlocHelper();

    // Detail Movie
    registerFallbackValue(DetailMovieStateHelper());
    registerFallbackValue(DetailMovieEventHelper());
    detailMovieBlocHelper = DetailMovieBlocHelper();

    // WatchList Movie
    registerFallbackValue(WatchlistMovieStateHelper());
    registerFallbackValue(WatchlistMovieEventHelper());
    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(
          create: (_) => detailMovieBlocHelper,
        ),
        BlocProvider<RecommendationsBloc>(
          create: (_) => recommedationsMovieBlocHelper,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => watchlistMovieBlocHelper,
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
      when(() => detailMovieBlocHelper.state).thenReturn(MovieLoading());
      when(() => recommedationsMovieBlocHelper.state)
          .thenReturn(MovieLoading());
      when(() => watchlistMovieBlocHelper.state).thenReturn(MovieLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(
        _makeTestableWidget(
          const MovieDetailPage(
            id: 1,
          ),
        ),
      );

      await widgetTester.pump();

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Watchlist button should display add when movie not added to watch list',
    ((WidgetTester widgetTester) async {
      when(() => detailMovieBlocHelper.state).thenReturn(
        MovieDetailHasData(testMovieDetail),
      );
      when(() => recommedationsMovieBlocHelper.state).thenReturn(
        MovieHasData(testMovieList),
      );
      when(() => watchlistMovieBlocHelper.state).thenReturn(
        const LoadWatchlistData(false),
      );

      final watchListButtonIcon = find.byIcon(Icons.add);

      await widgetTester.pumpWidget(
        _makeTestableWidget(
          const MovieDetailPage(
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
      when(() => detailMovieBlocHelper.state).thenReturn(
        MovieDetailHasData(testMovieDetail),
      );
      when(() => recommedationsMovieBlocHelper.state).thenReturn(
        MovieHasData(testMovieList),
      );
      when(() => watchlistMovieBlocHelper.state).thenReturn(
        const LoadWatchlistData(true),
      );

      final watchListButtonIcon = find.byIcon(Icons.check);

      await widgetTester.pumpWidget(
        _makeTestableWidget(
          const MovieDetailPage(
            id: 1,
          ),
        ),
      );

      await widgetTester.pump();

      expect(watchListButtonIcon, findsOneWidget);
    }),
  );
}
