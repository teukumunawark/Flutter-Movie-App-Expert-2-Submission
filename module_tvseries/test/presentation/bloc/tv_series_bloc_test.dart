import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:module_common/module_common.dart';
import 'package:module_tvseries/domain/entities/tv_series.dart';
import 'package:module_tvseries/domain/usecases/get_on_the_air_tv.dart';
import 'package:module_tvseries/domain/usecases/get_popular_tv_series.dart';
import 'package:module_tvseries/domain/usecases/get_recommendations.dart';
import 'package:module_tvseries/domain/usecases/get_top_rated_tv.dart';
import 'package:module_tvseries/domain/usecases/get_tv_series_detail.dart';
import 'package:module_tvseries/domain/usecases/get_watchlist_status.dart';
import 'package:module_tvseries/domain/usecases/get_watchlist_tv_series.dart';
import 'package:module_tvseries/domain/usecases/remove_watchlist.dart';
import 'package:module_tvseries/domain/usecases/save_watchlist.dart';
import 'package:module_tvseries/domain/usecases/search_tv_series.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetTvSeriesRecommendations,
  SearchTvSeries,
  GetTvSeriesDetail,
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  // On The Air TV Series
  late OnTheAirTvSeriesBloc onTheAirTvSeries;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;

  // Popular TV Series
  late PopularTvSeriesBloc popularTvseries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  // Top Rated TV Series
  late TopRatedTvSeriesBloc topRatedTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  // Search TV Series
  late SearchTvSeriesBloc searchTvSeries;
  late MockSearchTvSeries mockSearchTvSeries;

  // Recommendation TV Series
  late RecommendationsTvBloc recommendationsTvSeries;
  late MockGetTvSeriesRecommendations mockGetTvRecommendations;

  // Detail TV Series
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  // Watchlist TV Series
  late WatchlistTvSeriesBloc watchlistTvSeries;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    // On The Air TV Series
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    onTheAirTvSeries = OnTheAirTvSeriesBloc(mockGetOnTheAirTvSeries);

    // On The Air TV Series
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvseries = PopularTvSeriesBloc(mockGetPopularTvSeries);

    // Top Rated TV Series
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeries = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);

    // Search TV Series
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeries = SearchTvSeriesBloc(mockSearchTvSeries);

    // Recommendation TV Series
    mockGetTvRecommendations = MockGetTvSeriesRecommendations();
    recommendationsTvSeries = RecommendationsTvBloc(mockGetTvRecommendations);

    // Detail TV Series
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    detailTvSeriesBloc = DetailTvSeriesBloc(mockGetTvSeriesDetail);

    // Watchlist TvSeries
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    watchlistTvSeries = WatchlistTvSeriesBloc(
      mockGetWatchlistTvSeries,
      mockGetWatchListStatusTvSeries,
      mockSaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
    );
  });

  final tTvSeries = TvSeries(
    backdropPath: '/nVKaObLEsiPyqfmrPXW4BW1MT3n.jpg',
    firstAirDate: DateTime.parse('1967-09-09'),
    genreIds: const [10762, 16, 10759],
    id: 1482,
    name: 'Spider-Man',
    originCountry: const ['CA', 'US'],
    originalLanguage: 'en',
    originalName: 'Spider-Man',
    overview:
        'Spider-Man is an animated television series that ran from September 9, 1967 to June 14, 1970. It was jointly produced in Canada and the United States and was the first animated adaptation of the Spider-Man comic book series, created by writer Stan Lee and artist Steve Ditko. It first aired on the ABC television network in the United States but went into syndication at the start of the third season. Grantray-Lawrence Animation produced the first season. Seasons 2 and 3 were crafted by producer Ralph Bakshi in New York City. In Canada, it is currently airing on Teletoon Retro. An internet meme, commonly known as 1960s Spiderman, regarding the series has received an overwhelming amount of popularity. The meme consists of a screenshot taken at a random part of the series and adding an inappropriate and/or witty text. Since the death of Max Ferguson on March 7 2013, there are only three surviving members from the cast. Those three being Paul Soles the voice of Spider-Man, Chris Wiggins the voice of Mysterio and Carl Banas the voice of the Scorpion.',
    popularity: 19.348,
    posterPath: '/n6eMF2lPQxiGmh2D612R5Tuxbzm.jpg',
    voteAverage: 7.8,
    voteCount: 162,
  );

  final tTvSeriesList = [tTvSeries];
  const tQuery = 'spiderman';
  const tId = 1482;

  group("Get On The Air TV Series", () {
    test("initial state should be Loading", () {
      expect(onTheAirTvSeries.state, TvSeriesLoading());
    });

    blocTest<OnTheAirTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetOnTheAirTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return onTheAirTvSeries;
      },
      act: (bloc) => bloc.add(OnTvSeriesTheAir()),
      expect: () => [
        TvSeriesLoading(),
        TvSeriesHasData(tTvSeriesList),
      ],
      verify: (bloc) => verify(mockGetOnTheAirTvSeries.execute()),
    );

    blocTest<OnTheAirTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, Error] when get tv series is unsuccessful",
      build: () {
        when(mockGetOnTheAirTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return onTheAirTvSeries;
      },
      act: (bloc) => bloc.add(OnTvSeriesTheAir()),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetOnTheAirTvSeries.execute()),
    );
  });

  group("Get Popular TV Series", () {
    test("initial state should be Loading", () {
      expect(popularTvseries.state, TvSeriesLoading());
    });
    blocTest<PopularTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return popularTvseries;
      },
      act: (bloc) => bloc.add(OnPopularTvSeries()),
      expect: () => [
        TvSeriesLoading(),
        TvSeriesHasData(tTvSeriesList),
      ],
      verify: (bloc) => verify(mockGetPopularTvSeries.execute()),
    );

    blocTest<PopularTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, Error] when get tv series is unsuccessful",
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return popularTvseries;
      },
      act: (bloc) => bloc.add(OnPopularTvSeries()),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetPopularTvSeries.execute()),
    );
  });

  group("Get Top Rated Tv Series", () {
    test("initial state should be Loading", () {
      expect(topRatedTvSeries.state, TvSeriesLoading());
    });

    blocTest<TopRatedTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return topRatedTvSeries;
      },
      act: (bloc) => bloc.add(OnTopRatedTvSeries()),
      expect: () => [
        TvSeriesLoading(),
        TvSeriesHasData(tTvSeriesList),
      ],
      verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
    );

    blocTest<TopRatedTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, Error] when get tv series is unsuccessful",
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return topRatedTvSeries;
      },
      act: (bloc) => bloc.add(OnTopRatedTvSeries()),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
    );
  });

  group("Search Tv Series", () {
    test("initial state should be Loading", () {
      expect(searchTvSeries.state, TvSeriesLoading());
    });

    blocTest<SearchTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return searchTvSeries;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTvSeries(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSeriesLoading(),
        TvSeriesSearchHasData(tTvSeriesList),
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
    );

    blocTest<SearchTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, Error] when get tv series is unsuccessful",
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return searchTvSeries;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTvSeries(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError("Server Failure"),
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
    );
  });

  group(
    "Get TV Series Recommendation",
    () {
      test("initial state should be Loading", () {
        expect(recommendationsTvSeries.state, TvSeriesLoading());
      });

      blocTest<RecommendationsTvBloc, TvSeriesState>(
        "Should emit [Loading, HasData] when data is gotten successfully",
        build: () {
          when(mockGetTvRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tTvSeriesList));
          return recommendationsTvSeries;
        },
        act: (bloc) => bloc.add(const OnRecommendationTvSeries(tId)),
        expect: () => [
          TvSeriesLoading(),
          TvSeriesHasData(tTvSeriesList),
        ],
        verify: (bloc) => verify(mockGetTvRecommendations.execute(tId)),
      );

      blocTest<RecommendationsTvBloc, TvSeriesState>(
        "Should emit [Loading, Error] when get tv series is unsuccessful",
        build: () {
          when(mockGetTvRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return recommendationsTvSeries;
        },
        act: (bloc) => bloc.add(const OnRecommendationTvSeries(tId)),
        expect: () => [
          TvSeriesLoading(),
          const TvSeriesError("Server Failure"),
        ],
        verify: (bloc) => verify(mockGetTvRecommendations.execute(tId)),
      );
    },
  );

  group("Get Detail TV Series", () {
    test("initial state should be Loading", () {
      expect(detailTvSeriesBloc.state, TvSeriesLoading());
    });

    blocTest<DetailTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnDetailTvSeries(tId)),
      expect: () => [
        TvSeriesLoading(),
        TvSeriesDetailHasData(testTvSeriesDetail),
      ],
      verify: (bloc) => verify(mockGetTvSeriesDetail.execute(tId)),
    );

    blocTest<DetailTvSeriesBloc, TvSeriesState>(
      "Should emit [Loading, Error] when get detail series is unsuccessful",
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnDetailTvSeries(tId)),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetTvSeriesDetail.execute(tId)),
    );
  });

  group("Watchlist Tv Series", () {
    test("initial state should be Loading", () {
      expect(watchlistTvSeries.state, TvSeriesEmpty());
    });

    group("Get Watchlist TV Series", () {
      blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
        "Should emit [Loading, HasData] when data is gotten successfully",
        build: () {
          when(mockGetWatchlistTvSeries.execute())
              .thenAnswer((_) async => Right(tTvSeriesList));
          return watchlistTvSeries;
        },
        act: (bloc) => bloc.add(OnWatchlistTvSeries()),
        expect: () => [
          TvSeriesLoading(),
          TvSeriesWatchlistHasData(tTvSeriesList),
        ],
        verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
      );

      blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
        "Should emit [Loading, Error] when get detail series is unsuccessful",
        build: () {
          when(mockGetWatchlistTvSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return watchlistTvSeries;
        },
        act: (bloc) => bloc.add(OnWatchlistTvSeries()),
        expect: () => [
          TvSeriesLoading(),
          const TvSeriesError("Server Failure"),
        ],
        verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
      );
    });

    group(
      "Get Watchlist TV Series Status",
      () {
        blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
          "Should emit [Loading, HasData] when data is gotten successfully",
          build: () {
            when(mockGetWatchListStatusTvSeries.execute(tId))
                .thenAnswer((realInvocation) async => true);
            return watchlistTvSeries;
          },
          act: (bloc) => bloc.add(const OnLoadWatchlistStatusTvSeries(tId)),
          expect: () => [
            TvSeriesLoading(),
            const TvSeriesWatchlistLoadData(true),
          ],
          verify: (bloc) => verify(mockGetWatchListStatusTvSeries.execute(tId)),
        );

        blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
          "Should emit [Loading, Error] when get detail series is unsuccessful",
          build: () {
            when(mockGetWatchListStatusTvSeries.execute(tId))
                .thenAnswer((realInvocation) async => false);
            return watchlistTvSeries;
          },
          act: (bloc) => bloc.add(const OnLoadWatchlistStatusTvSeries(tId)),
          expect: () => [
            TvSeriesLoading(),
            const TvSeriesWatchlistLoadData(false),
          ],
          verify: (bloc) => verify(mockGetWatchListStatusTvSeries.execute(tId)),
        );
      },
    );

    group("Save Watch List Tv Series", () {
      blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
        "Should emit [Loading, HasData] when data is gotten successfully",
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async =>
                  const Right(WatchlistTvSeriesBloc.messageAddedToWatchlist));
          return watchlistTvSeries;
        },
        act: (bloc) => bloc.add(OnSaveWatchlistTvSeries(testTvSeriesDetail)),
        expect: () => [
          TvSeriesLoading(),
          const TvSeriesWatchlistMessage(
              WatchlistTvSeriesBloc.messageAddedToWatchlist)
        ],
        verify: (bloc) =>
            verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)),
      );

      blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
        "Should emit [Loading, Error] when get detail series is unsuccessful",
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return watchlistTvSeries;
        },
        act: (bloc) => bloc.add(OnSaveWatchlistTvSeries(testTvSeriesDetail)),
        expect: () => [
          TvSeriesLoading(),
          const TvSeriesError("Server Failure"),
        ],
        verify: (bloc) =>
            verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)),
      );
    });

    group("Remove  Watch List Tv Series", () {
      blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
        "Should emit [Loading, HasData] when data is gotten successfully",
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async =>
                  const Right(WatchlistTvSeriesBloc.messageRemoveToWatchlist));
          return watchlistTvSeries;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistTvSeries(testTvSeriesDetail)),
        expect: () => [
          TvSeriesLoading(),
          const TvSeriesWatchlistMessage(
              WatchlistTvSeriesBloc.messageRemoveToWatchlist)
        ],
        verify: (bloc) =>
            verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)),
      );

      blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
        "Should emit [Loading, Error] when get detail series is unsuccessful",
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async => left(ServerFailure("Server Failure")));
          return watchlistTvSeries;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistTvSeries(testTvSeriesDetail)),
        expect: () => [
          TvSeriesLoading(),
          const TvSeriesError("Server Failure"),
        ],
        verify: (bloc) =>
            verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)),
      );
    });
  });
}
