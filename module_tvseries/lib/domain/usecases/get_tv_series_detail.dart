import 'package:dartz/dartz.dart';
import 'package:module_common/common/failure.dart';
import 'package:module_tvseries/domain/entities/tv_series_detail.dart';
import 'package:module_tvseries/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getDetailTvSeries(id);
  }
}
