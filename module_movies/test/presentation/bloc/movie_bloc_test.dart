import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:module_common/common/failure.dart';
import 'package:module_movies/domain/entities/genre.dart';
import 'package:module_movies/domain/entities/movie.dart';
import 'package:module_movies/domain/entities/movie_detail.dart';
import 'package:module_movies/domain/usecases/get_movie_detail.dart';
import 'package:module_movies/domain/usecases/get_movie_recommendations.dart';
import 'package:module_movies/domain/usecases/get_now_playing_movies.dart';
import 'package:module_movies/domain/usecases/get_popular_movies.dart';
import 'package:module_movies/domain/usecases/get_top_rated_movies.dart';
import 'package:module_movies/domain/usecases/get_watchlist_movies.dart';
import 'package:module_movies/domain/usecases/get_watchlist_status.dart';
import 'package:module_movies/domain/usecases/remove_watchlist.dart';
import 'package:module_movies/domain/usecases/save_watchlist.dart';
import 'package:module_movies/domain/usecases/search_movies.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieRecommendations,
  GetMovieDetail,
  SearchMovies,
  GetWatchListStatusMovie,
  GetWatchlistMovies,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {
  // Now Playing
  late NowPlayingMovieBloc nowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  // Popular
  late PopularMovieBloc popularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  // Top Rated
  late TopRatedMovieBloc topRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  // Recommendations
  late RecommendationsBloc recommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  // Search
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovies;

  // Detail
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  // Watchlist
  late WatchlistMovieBloc watchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    // Now Playing
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);

    // Popular
    mockGetPopularMovies = MockGetPopularMovies();
    popularBloc = PopularMovieBloc(mockGetPopularMovies);

    // Top Rated
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedMovieBloc(mockGetTopRatedMovies);

    // Recommendations
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationsBloc = RecommendationsBloc(mockGetMovieRecommendations);

    // Search
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);

    // Detail
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);

    // Watchlist
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    watchlistBloc = WatchlistMovieBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatusMovie,
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';
  const tId = 1;

  group("Get Now Playing Movie", () {
    test("initial state should be Loading", () {
      expect(nowPlayingBloc.state, MovieLoading());
    });

    blocTest<NowPlayingMovieBloc, MovieState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovie()),
      expect: () => [
        MovieLoading(),
        MovieHasData(tMovieList),
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
    );

    blocTest<NowPlayingMovieBloc, MovieState>(
      "Should emit [Loading, Error] when get movie is unsuccessful",
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovie()),
      expect: () => [
        MovieLoading(),
        const MovieError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
    );
  });

  group("Get no Popular Movie", () {
    test("intial state should be Loading", () {
      expect(topRatedBloc.state, MovieLoading());
    });

    blocTest<PopularMovieBloc, MovieState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnPopularMovie()),
      expect: () => [
        MovieLoading(),
        MovieHasData(tMovieList),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );

    blocTest<PopularMovieBloc, MovieState>(
      "Should emit [Loading, Error] when get movie is unsuccessful",
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnPopularMovie()),
      expect: () => [
        MovieLoading(),
        const MovieError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );
  });

  group("Get Top Rated Movie", () {
    test("intial state should be Loading", () {
      expect(topRatedBloc.state, MovieLoading());
    });

    blocTest<TopRatedMovieBloc, MovieState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedMovie()),
      expect: () => [
        MovieLoading(),
        MovieHasData(tMovieList),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );

    blocTest<TopRatedMovieBloc, MovieState>(
      "Should emit [Loading, Error] when get movie is unsuccessful",
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedMovie()),
      expect: () => [
        MovieLoading(),
        const MovieError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );
  });

  group("Get Recommendation Movie", () {
    test("initial state should be Loading ", () {
      expect(recommendationsBloc.state, MovieLoading());
    });

    blocTest<RecommendationsBloc, MovieState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnRecommendationMovie(tId)),
      expect: () => [
        MovieLoading(),
        MovieHasData(tMovieList),
      ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId)),
    );

    blocTest<RecommendationsBloc, MovieState>(
      "Should emit [Loading, Error] when get search is unsuccessful",
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return recommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnRecommendationMovie(tId)),
      expect: () => [
        MovieLoading(),
        const MovieError("Server Failure"),
      ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId)),
    );
  });

  group("search movies", () {
    test('initial state should be empty', () {
      expect(searchMovieBloc.state, MovieEmpty());
    });
    blocTest<SearchMovieBloc, MovieState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        SearchHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMovieBloc, MovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        const MovieError("Server Failure"),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });

  group("Get Detail Movie", () {
    test("initial state should be Loading", () {
      expect(recommendationsBloc.state, MovieLoading());
    });

    blocTest<DetailMovieBloc, MovieState>(
      "Should emit [Loading, HasData] when data is gotten successfully",
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const OnDetailMovie(tId)),
      expect: () => [
        MovieLoading(),
        MovieDetailHasData(tMovieDetail),
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId)),
    );

    blocTest<DetailMovieBloc, MovieState>(
      "Should emit [Loading, Error] when get detail movie is unsuccessful",
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const OnDetailMovie(tId)),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId)),
    );
  });

  group("Watchlist Movie", () {
    test("initial state should be Empty Data", () {
      expect(watchlistBloc.state, MovieEmpty());
    });
    group("Get Watchlist Movie", () {
      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, HasData] when data is gotten successfully",
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlist()),
        expect: () => [
          MovieLoading(),
          WatchlistHasData(tMovieList),
        ],
        verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
      );

      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, Error] when get watchlist movie is unsuccessful",
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure("Server Failure")));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlist()),
        expect: () => [
          MovieLoading(),
          const MovieError("Server Failure"),
        ],
        verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
      );
    });

    group("Save Watchlist Movie", () {
      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, HasData] when data is gotten successfully",
        build: () {
          when(mockSaveWatchlistMovie.execute(tMovieDetail)).thenAnswer(
              (_) async =>
                  const Right(WatchlistMovieBloc.messageAddedToWatchlist));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnSaveWatchlist(tMovieDetail)),
        expect: () => [
          MovieLoading(),
          const WatchlistMessage(WatchlistMovieBloc.messageAddedToWatchlist)
        ],
        verify: (bloc) => verify(mockSaveWatchlistMovie.execute(tMovieDetail)),
      );
      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, Error] when save movie is unsuccessful",
        build: () {
          when(mockSaveWatchlistMovie.execute(tMovieDetail)).thenAnswer(
              (_) async => const Left(ServerFailure("Server Failure")));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnSaveWatchlist(tMovieDetail)),
        expect: () => [
          MovieLoading(),
          const MovieError("Server Failure"),
        ],
        verify: (bloc) => verify(mockSaveWatchlistMovie.execute(tMovieDetail)),
      );
    });

    group("Remove Watchlist Movie", () {
      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, HasData] when data is gotten successfully",
        build: () {
          when(mockRemoveWatchlistMovie.execute(tMovieDetail)).thenAnswer(
              (_) async =>
                  const Right(WatchlistMovieBloc.messageRemoveToWatchlist));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlist(tMovieDetail)),
        expect: () => [
          MovieLoading(),
          const WatchlistMessage(WatchlistMovieBloc.messageRemoveToWatchlist)
        ],
        verify: (bloc) =>
            verify(mockRemoveWatchlistMovie.execute(tMovieDetail)),
      );

      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, Error] when remove movie is unsuccessful",
        build: () {
          when(mockRemoveWatchlistMovie.execute(tMovieDetail)).thenAnswer(
              (_) async => const Left(ServerFailure("Server Failure")));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlist(tMovieDetail)),
        expect: () => [
          MovieLoading(),
          const MovieError("Server Failure"),
        ],
        verify: (bloc) =>
            verify(mockRemoveWatchlistMovie.execute(tMovieDetail)),
      );
    });

    group("Load Watchlist Movie", () {
      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, Load(true)] when data is gotten successfully",
        build: () {
          when(mockGetWatchListStatusMovie.execute(tId))
              .thenAnswer((realInvocation) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(const OnLoadWatchlistStatus(tId)),
        expect: () => [
          MovieLoading(),
          const LoadWatchlistData(true),
        ],
        verify: (bloc) => verify(mockGetWatchListStatusMovie.execute(tId)),
      );

      blocTest<WatchlistMovieBloc, MovieState>(
        "Should emit [Loading, Load(false)] when remove movie is unsuccessful",
        build: () {
          when(mockGetWatchListStatusMovie.execute(tId))
              .thenAnswer((realInvocation) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(const OnLoadWatchlistStatus(tId)),
        expect: () => [
          MovieLoading(),
          const LoadWatchlistData(false),
        ],
      );
    });
  });
}
