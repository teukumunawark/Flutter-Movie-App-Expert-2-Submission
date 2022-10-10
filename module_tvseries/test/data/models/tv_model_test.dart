import 'package:flutter_test/flutter_test.dart';
import 'package:module_tvseries/data/models/tv_models.dart';
import 'package:module_tvseries/domain/entities/tv_series.dart';

void main() {
  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2000-09-11'),
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry', 'originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2,
    posterPath: 'posterPath',
    voteAverage: 123,
    voteCount: 456,
  );

  final tTvSeriesModel = TvSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2000-09-11'),
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry', 'originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2,
    posterPath: 'posterPath',
    voteAverage: 123,
    voteCount: 456,
  );

  test('should be a subclass of Tv Series Entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
