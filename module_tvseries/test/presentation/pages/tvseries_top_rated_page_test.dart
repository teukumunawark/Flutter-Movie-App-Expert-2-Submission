import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';
import 'package:module_tvseries/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_bloc_helper.dart';

void main() {
  late TopRatedTvBlocHelper topRatedTvBlocHelper;

  setUp(() {
    registerFallbackValue(TopRatedTvStateHelper());
    registerFallbackValue(TopRatedTvEventHelper());
    topRatedTvBlocHelper = TopRatedTvBlocHelper();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>(
      create: (_) => topRatedTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    topRatedTvBlocHelper.close();
  });

  testWidgets(
    'Page should display center progress bar when loading',
    ((WidgetTester widgetTester) async {
      when(() => topRatedTvBlocHelper.state).thenReturn(TvSeriesLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(
        _makeTestableWidget(const TopRatedTvSeriesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester widgetTester) async {
      when(() => topRatedTvBlocHelper.state).thenReturn(TvSeriesLoading());
      when(() => topRatedTvBlocHelper.state)
          .thenReturn(TvSeriesHasData(testTvSeriesList));

      final listview = find.byType(ListView);

      await widgetTester.pumpWidget(
        _makeTestableWidget(const TopRatedTvSeriesPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester widgetTester) async {
      when(() => topRatedTvBlocHelper.state).thenReturn(TvSeriesLoading());
      when(() => topRatedTvBlocHelper.state)
          .thenReturn(const TvSeriesError("Error message"));

      final key = find.byKey(const Key("Error message"));

      await widgetTester.pumpWidget(
        _makeTestableWidget(const TopRatedTvSeriesPage()),
      );

      expect(key, findsOneWidget);
    }),
  );
}
