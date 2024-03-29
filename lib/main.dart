import 'package:dimovie_final_expert_project/firebase_options.dart';
import 'package:dimovie_final_expert_project/ssl/ssl_pinning_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_common/module_common.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';
import 'package:module_movies/presentation/pages/home_movie_page.dart';
import 'package:module_movies/presentation/pages/movie_detail_page.dart';
import 'package:module_movies/presentation/pages/popular_movies_page.dart';
import 'package:module_movies/presentation/pages/search_page.dart';
import 'package:module_movies/presentation/pages/top_rated_movies_page.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';
import 'package:module_tvseries/presentation/pages/home_tv_series_page.dart';
import 'package:module_tvseries/presentation/pages/populat_tv_series_page.dart';
import 'package:module_tvseries/presentation/pages/search_page.dart';
import 'package:module_tvseries/presentation/pages/top_rated_tv_page.dart';
import 'package:module_tvseries/presentation/pages/tv_series_detail_page.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SslPinningHelper.initializing();

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // MOVIE BLOC
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),

        // TV SERIES BLOC
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationsTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // Movie Route
            case HomeMoviePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const HomeMoviePage(),
              );
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case SearchPageMovie.routeName:
              return CupertinoPageRoute(
                builder: (_) => const SearchPageMovie(),
              );
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            // TV Series Route
            case TvSeriesPage.routeName:
              return MaterialPageRoute(builder: (_) => const TvSeriesPage());
            case PopularTvSeriesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const PopularTvSeriesPage());
            case TopRatedTvSeriesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedTvSeriesPage());
            case SearchPageTvSeries.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const SearchPageTvSeries());
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
