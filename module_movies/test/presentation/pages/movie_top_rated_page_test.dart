import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';
import 'package:module_movies/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_movie_bloc_helper.dart';

void main() {
  late TopRatedMovieBlocHelper topRatedMovieBlocHelper;

  setUpAll(() {
    topRatedMovieBlocHelper = TopRatedMovieBlocHelper();
    registerFallbackValue(PopularMovieStateHelper());
    registerFallbackValue(PopularMovieEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (_) => topRatedMovieBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    topRatedMovieBlocHelper.close();
  });

  testWidgets(
    'Page should display center progress bar when loading',
    ((WidgetTester widgetTester) async {
      when(() => topRatedMovieBlocHelper.state).thenReturn(MovieLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(
        _makeTestableWidget(const TopRatedMoviesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester widgetTester) async {
      when(() => topRatedMovieBlocHelper.state).thenReturn(MovieLoading());
      when(() => topRatedMovieBlocHelper.state)
          .thenReturn(MovieHasData(testMovieList));

      final circularProgressIndicator = find.byType(ListView);

      await widgetTester.pumpWidget(
        _makeTestableWidget(const TopRatedMoviesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester widgetTester) async {
      when(() => topRatedMovieBlocHelper.state).thenReturn(MovieLoading());
      when(() => topRatedMovieBlocHelper.state)
          .thenReturn(const MovieError("Error message"));

      final circularProgressIndicator = find.byKey(const Key('Error message'));

      await widgetTester.pumpWidget(
        _makeTestableWidget(const TopRatedMoviesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );
}
