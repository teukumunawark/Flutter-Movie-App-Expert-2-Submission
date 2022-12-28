import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';
import 'package:module_movies/presentation/widgets/movie_card_list.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';
import 'package:module_tvseries/presentation/widgets/tv_card_list.dart';
import '../common/utils.dart';

class WatchlistPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistMovietate();
}

class _WatchlistMovietate extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(OnWatchlist());
      context.read<WatchlistTvSeriesBloc>().add(OnWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnWatchlist());
    context.read<WatchlistTvSeriesBloc>().add(OnWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                text: 'Movies',
                icon: Icon(Icons.movie_creation_outlined),
              ),
              Tab(
                text: 'TV Series',
                icon: Icon(Icons.tv_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildWatchlistMovie(),
            buildWatchlistTvSeries(),
          ],
        ),
      ),
    );
  }

  Padding buildWatchlistMovie() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movieData = state.watchlist[index];
                return MovieCard(movieData);
              },
              itemCount: state.watchlist.length,
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
              child: Text("Failed"),
            );
          }
        },
      ),
    );
  }

  Padding buildWatchlistTvSeries() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvSeriesBloc, TvSeriesState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesWatchlistHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvseriesData = state.watchlist[index];
                return TvSeriesCard(tvseriesData);
              },
              itemCount: state.watchlist.length,
            );
          } else if (state is TvSeriesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
              child: Text("Failed"),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
