import 'package:dartz/dartz.dart';
import 'package:module_common/common/failure.dart';
import 'package:module_tvseries/domain/entities/tv_series.dart';
import 'package:module_tvseries/domain/repositories/tv_series_repository.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
