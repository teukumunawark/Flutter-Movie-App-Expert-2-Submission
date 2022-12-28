import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:module_common/common/constants.dart';
import 'package:module_movies/domain/entities/movie.dart';
import 'package:module_movies/domain/entities/movie_detail.dart';
import 'package:module_movies/presentation/bloc/movie_bloc.dart';

import '../../domain/entities/genre.dart';

class MovieDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const routeName = '/detail-movie';

  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(OnDetailMovie(widget.id));
      context.read<RecommendationsBloc>().add(OnRecommendationMovie(widget.id));
      context.read<WatchlistMovieBloc>().add(OnLoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesRecommendation =
        context.select<RecommendationsBloc, List<Movie>>((value) {
      var state = value.state;
      if (state is MovieHasData) {
        return (state).movies;
      }
      return [];
    });

    var isAddedToWatchlist = context.select<WatchlistMovieBloc, bool>((value) {
      var state = value.state;
      if (state is LoadWatchlistData) {
        return state.isWatchlist;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            return SafeArea(
              child: DetailContent(
                state.movieDetail,
                moviesRecommendation,
                isAddedToWatchlist,
              ),
            );
          } else if (state is MovieError) {
            return Center(
              key: const Key("Error message"),
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.recommendations, this.isAddedWatchlist,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(OnSaveWatchlist(movie));
                                } else {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(OnRemoveWatchlist(movie));
                                }

                                String message = '';

                                final state =
                                    BlocProvider.of<WatchlistMovieBloc>(context)
                                        .state;

                                if (state is LoadWatchlistData) {
                                  message = isAddedWatchlist
                                      ? WatchlistMovieBloc
                                          .messageRemoveToWatchlist
                                      : WatchlistMovieBloc
                                          .messageAddedToWatchlist;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? WatchlistMovieBloc
                                          .messageAddedToWatchlist
                                      : WatchlistMovieBloc
                                          .messageRemoveToWatchlist;
                                }

                                if (message ==
                                        WatchlistMovieBloc
                                            .messageAddedToWatchlist ||
                                    message ==
                                        WatchlistMovieBloc
                                            .messageRemoveToWatchlist) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          content: Text(
                                            message,
                                          )));
                                  //LOAD NEW STATUS
                                  BlocProvider.of<WatchlistMovieBloc>(context)
                                      .add(OnLoadWatchlistStatus(movie.id));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          MovieDetailPage.routeName,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
