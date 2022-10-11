import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';
import 'package:module_movies/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_movie_bloc_helper.dart';

void main() {
  late PopularMovieBlocHelper popularMovieBlocHelper;

  setUp(() {
    popularMovieBlocHelper = PopularMovieBlocHelper();
    registerFallbackValue(PopularMovieStateHelper());
    registerFallbackValue(PopularMovieEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => popularMovieBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularMovieBlocHelper.close();
  });

  testWidgets(
    'Page should display center progress bar when loading',
    ((WidgetTester widgetTester) async {
      when(() => popularMovieBlocHelper.state).thenReturn(MovieLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(
        _makeTestableWidget(const PopularMoviesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester widgetTester) async {
      when(() => popularMovieBlocHelper.state).thenReturn(MovieLoading());
      when(() => popularMovieBlocHelper.state)
          .thenReturn(MovieHasData(testMovieList));

      final listview = find.byType(ListView);

      await widgetTester.pumpWidget(
        _makeTestableWidget(const PopularMoviesPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester widgetTester) async {
      when(() => popularMovieBlocHelper.state).thenReturn(MovieLoading());
      when(() => popularMovieBlocHelper.state)
          .thenReturn(const MovieError("Error message"));

      final key = find.byKey(const Key('Error message'));

      await widgetTester.pumpWidget(
        _makeTestableWidget(const PopularMoviesPage()),
      );

      expect(key, findsOneWidget);
    }),
  );
}
