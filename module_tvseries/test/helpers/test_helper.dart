import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:module_tvseries/data/datasources/db/database_helper.dart';
import 'package:module_tvseries/data/datasources/tv_series_local_data_source.dart';
import 'package:module_tvseries/data/datasources/tv_series_remote_data_source.dart';
import 'package:module_tvseries/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  TvSeriesDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
