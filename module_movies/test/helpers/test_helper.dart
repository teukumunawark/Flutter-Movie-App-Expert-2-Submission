import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:module_movies/data/datasources/db/database_helper.dart';
import 'package:module_movies/data/datasources/movie_local_data_source.dart';
import 'package:module_movies/data/datasources/movie_remote_data_source.dart';
import 'package:module_movies/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
