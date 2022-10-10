import 'package:dartz/dartz.dart';
import 'package:module_common/common/failure.dart';
import 'package:module_movies/domain/entities/movie_detail.dart';
import 'package:module_movies/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
