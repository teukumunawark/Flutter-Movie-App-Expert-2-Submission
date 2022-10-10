import 'package:dartz/dartz.dart';
import 'package:module_common/common/failure.dart';
import 'package:module_tvseries/domain/entities/tv_series.dart';
import 'package:module_tvseries/domain/repositories/tv_series_repository.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
