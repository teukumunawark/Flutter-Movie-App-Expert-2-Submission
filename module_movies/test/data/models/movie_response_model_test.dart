import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_movies/data/models/genre_model.dart';
import 'package:module_movies/data/models/movie_detail_model.dart';
import 'package:module_movies/data/models/movie_model.dart';
import 'package:module_movies/data/models/movie_response.dart';

import '../../json_reader.dart';

void main() {
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: const [1, 2, 3, 4],
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovieResponseModel = MovieResponse(
    movieList: <MovieModel>[tMovieModel],
  );

  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    budget: 100,
    genres: [
      GenreModel(id: 1, name: 'Action'),
    ],
    homepage: "https://google.com",
    id: 1,
    imdbId: "imdb1",
    originalLanguage: "en",
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    revenue: 12000,
    runtime: 120,
    status: "Status",
    tagline: "Tagline",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('fromJson', () {
    // Now Playing Model Testing fromJson
    test('should return a valid Now Playing model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });

    // Popular Model Testing fromJson
    test('should return a valid popular model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/popular.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });

    //  Top Rated Testing fromJson
    test('should return a valid Top Rated model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/top_rated.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });

    // Detail Movie Testing fromJson
    test('should return a valid Movie Detail model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/movie_detail.json'));
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a movie list JSON map containing proper data',
        () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_title": "Original Title",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "release_date": "2020-05-05",
            "title": "Title",
            "video": false,
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });

    test('should return a detail movie JSON map containing proper data',
        () async {
      // arrange

      // act
      final result = tMovieDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        'adult': false,
        'backdrop_path': '/path.jpg',
        'budget': 100,
        'genres': [
          {'id': 1, 'name': 'Action'}
        ],
        'homepage': 'https://google.com',
        'id': 1,
        'imdb_id': 'imdb1',
        'original_language': 'en',
        'original_title': 'Original Title',
        'overview': 'Overview',
        'popularity': 1.0,
        'poster_path': '/path.jpg',
        'release_date': '2020-05-05',
        'revenue': 12000,
        'runtime': 120,
        'status': 'Status',
        'tagline': 'Tagline',
        'title': 'Title',
        'video': false,
        'vote_average': 1.0,
        'vote_count': 1
      };

      expect(result, expectedJsonMap);
    });
  });
}
