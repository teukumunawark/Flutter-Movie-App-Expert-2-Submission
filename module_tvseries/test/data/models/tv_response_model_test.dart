import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_movies/data/models/genre_model.dart';
import 'package:module_tvseries/data/models/next_episode_to_air_model.dart';
import 'package:module_tvseries/data/models/season_model.dart';
import 'package:module_tvseries/data/models/tv_detail_model.dart';
import 'package:module_tvseries/data/models/tv_models.dart';
import 'package:module_tvseries/data/models/tv_response.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
    firstAirDate: DateTime.parse('2000-09-11 11:11:11.591918'),
    genreIds: const [
      10765,
      18,
      10759,
    ],
    id: 94997,
    name: 'House of the Dragon',
    originCountry: const ["US"],
    originalLanguage: 'en',
    originalName: 'House of the Dragon',
    overview:
        'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
    popularity: 7490.466,
    posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
    voteAverage: 8.6,
    voteCount: 1437,
  );
  final tTvSeriesResponseModel =
      TvResponse(tvList: <TvSeriesModel>[tTvSeriesModel]);

  final tTvDetailResponseModel = TvDetailResponse(
    adult: false,
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    episodeRunTime: const [],
    firstAirDate: "2022-08-21",
    genres: [
      GenreModel(
        id: 10765,
        name: 'Sci-Fi & Fantasy',
      ),
      GenreModel(
        id: 18,
        name: "Drama",
      ),
      GenreModel(
        id: 10759,
        name: "Action & Adventure",
      ),
    ],
    id: 94997,
    lastAirDate: "2022-09-25",
    lastEpisodeToAir: const NextEpisodeToAirModel(
      airDate: "2022-09-25",
      episodeNumber: 6,
      id: 3846970,
      name: "The Princess and the Queen",
      overview:
          "Ten years later. Rhaenyra navigates Alicent’s continued speculation about her children, while Daemon and Laena weigh an offer in Pentos.",
      productionCode: "",
      runtime: 67,
      seasonNumber: 1,
      showId: 94997,
      stillPath: "/lcBTDoCkBTJAdi8VagMQdzB6RYi.jpg",
      voteAverage: 7.5,
      voteCount: 16,
    ),
    name: "House of the Dragon",
    nextEpisodeToAir: const NextEpisodeToAirModel(
      airDate: "2022-10-02",
      episodeNumber: 7,
      id: 3846973,
      name: "Driftmark",
      overview: "",
      productionCode: "",
      runtime: 58,
      seasonNumber: 1,
      showId: 94997,
      stillPath: "/xA7nljMF7gkV4YMvnuOlsenFuSl.jpg",
      voteAverage: 0.0,
      voteCount: 0,
    ),
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 5516.822,
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    seasons: [
      SeasonModel(
        airDate: DateTime.tryParse("2022-08-21"),
        episodeCount: 20,
        id: 309556,
        name: "Specials",
        overview: "",
        posterPath: "/qVU4112Ob2ikHBu4VRC50MdWZcM.jpg",
        seasonNumber: 0,
      ),
      SeasonModel(
        airDate: DateTime.tryParse("2022-08-21"),
        episodeCount: 10,
        id: 134965,
        name: "Season 1",
        overview: "",
        posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
        seasonNumber: 1,
      )
    ],
    status: "Returning Series",
    tagline: "Fire and blood.",
    type: "Scripted",
    voteAverage: 8.619,
    voteCount: 1456,
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model from JSON',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(readJson('dummy_data/on_the_air.json'));
          // act
          final result = TvResponse.fromJson(jsonMap);
          // assert
          expect(result, tTvSeriesResponseModel);
        },
      );
      test(
        'should return a valid model from JSON',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(readJson('dummy_data/on_the_air.json'));
          // act
          final result = TvResponse.fromJson(jsonMap);
          // assert
          expect(result, tTvSeriesResponseModel);
        },
      );
      test(
        'should return a valid model from JSON',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(readJson('dummy_data/popular.json'));
          // act
          final result = TvResponse.fromJson(jsonMap);
          // assert
          expect(result, tTvSeriesResponseModel);
        },
      );
      test(
        'should return a valid model from JSON',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(readJson('dummy_data/top_rated.json'));
          // act
          final result = TvResponse.fromJson(jsonMap);
          // assert
          expect(result, tTvSeriesResponseModel);
        },
      );
    },
  );

  group('toJson', () {
    test('should return a TV Series List JSON map containing proper data', () {
      //arrange
      //act
      final result = tTvSeriesResponseModel.toJson();
      //assert
      final expectedJsonMap = {
        'results': [
          {
            'backdrop_path': '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
            'first_air_date': '2000-09-11',
            'genre_ids': [10765, 18, 10759],
            'id': 94997,
            'name': 'House of the Dragon',
            'origin_country': ['US'],
            'original_language': 'en',
            'original_name': 'House of the Dragon',
            'overview':
                'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
            'popularity': 7490.466,
            'poster_path': '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
            'vote_average': 8.6,
            'vote_count': 1437
          }
        ]
      };
      expect(result, expectedJsonMap);
    });

    test('should return a TV Series Detail JSON map containing proper data',
        () {
      //arrange
      //act
      final result = tTvDetailResponseModel.toJson();
      //assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
        "episode_run_time": [],
        "first_air_date": "2022-08-21",
        "genres": [
          {"id": 10765, "name": "Sci-Fi & Fantasy"},
          {"id": 18, "name": "Drama"},
          {"id": 10759, "name": "Action & Adventure"}
        ],
        "id": 94997,
        "last_air_date": "2022-09-25",
        "last_episode_to_air": {
          "air_date": "2022-09-25",
          "episode_number": 6,
          "id": 3846970,
          "name": "The Princess and the Queen",
          "overview":
              "Ten years later. Rhaenyra navigates Alicent’s continued speculation about her children, while Daemon and Laena weigh an offer in Pentos.",
          "production_code": "",
          "runtime": 67,
          "season_number": 1,
          "show_id": 94997,
          "still_path": "/lcBTDoCkBTJAdi8VagMQdzB6RYi.jpg",
          "vote_average": 7.5,
          "vote_count": 16
        },
        "name": "House of the Dragon",
        "next_episode_to_air": {
          "air_date": "2022-10-02",
          "episode_number": 7,
          "id": 3846973,
          "name": "Driftmark",
          "overview": "",
          "production_code": "",
          "runtime": 58,
          "season_number": 1,
          "show_id": 94997,
          "still_path": "/xA7nljMF7gkV4YMvnuOlsenFuSl.jpg",
          "vote_average": 0.0,
          "vote_count": 0
        },
        "number_of_episodes": 10,
        "number_of_seasons": 1,
        "original_name": "House of the Dragon",
        "overview":
            "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
        "popularity": 5516.822,
        "poster_path": "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
        "status": "Returning Series",
        "tagline": "Fire and blood.",
        "type": "Scripted",
        "vote_average": 8.619,
        "vote_count": 1456
      };
      expect(result, expectedJsonMap);
    });
  });
}
