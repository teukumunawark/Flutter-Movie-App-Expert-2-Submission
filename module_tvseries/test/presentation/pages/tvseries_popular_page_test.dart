import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';
import 'package:module_tvseries/presentation/pages/populat_tv_series_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_bloc_helper.dart';

void main() {
  late PopularTvBlocHelper popularTvBlocHelper;

  setUp(() {
    registerFallbackValue(PopularTvStateHelper());
    registerFallbackValue(PopularTvEventHelper());
    popularTvBlocHelper = PopularTvBlocHelper();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>(
      create: (_) => popularTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularTvBlocHelper.close();
  });

  testWidgets(
    'Page should display center progress bar when loading',
    ((WidgetTester widgetTester) async {
      when(() => popularTvBlocHelper.state).thenReturn(TvSeriesLoading());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(
        makeTestableWidget(const PopularTvSeriesPage()),
      );

      expect(circularProgressIndicator, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    ((WidgetTester widgetTester) async {
      when(() => popularTvBlocHelper.state).thenReturn(TvSeriesLoading());
      when(() => popularTvBlocHelper.state)
          .thenReturn(TvSeriesHasData(testTvSeriesList));

      final listview = find.byType(ListView);

      await widgetTester.pumpWidget(
        makeTestableWidget(const PopularTvSeriesPage()),
      );

      expect(listview, findsOneWidget);
    }),
  );

  testWidgets(
    'Page should display text with message when Error',
    ((WidgetTester widgetTester) async {
      when(() => popularTvBlocHelper.state).thenReturn(TvSeriesLoading());
      when(() => popularTvBlocHelper.state)
          .thenReturn(const TvSeriesError("Error message"));

      final key = find.byKey(const Key("Error message"));

      await widgetTester.pumpWidget(
        makeTestableWidget(const PopularTvSeriesPage()),
      );

      expect(key, findsOneWidget);
    }),
  );
}
