import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:module_common/common/constants.dart';
import 'package:module_movies/domain/entities/genre.dart';
import 'package:module_tvseries/domain/entities/tv_series.dart';
import 'package:module_tvseries/domain/entities/tv_series_detail.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  TvSeriesDetailPageState createState() => TvSeriesDetailPageState();
}

class TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvSeriesBloc>().add(OnDetailTvSeries(widget.id));
      context.read<RecommendationsTvBloc>().add(
            OnRecommendationTvSeries(widget.id),
          );
      context.read<WatchlistTvSeriesBloc>().add(
            OnLoadWatchlistStatusTvSeries(widget.id),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final tvseriesRecommendation =
        context.select<RecommendationsTvBloc, List<TvSeries>>((value) {
      var state = value.state;
      if (state is TvSeriesHasData) {
        return (state).tvseries;
      }
      return [];
    });

    var isAddedToWatchlist =
        context.select<WatchlistTvSeriesBloc, bool>((value) {
      var state = value.state;
      if (state is TvSeriesWatchlistLoadData) {
        return state.isWatchlist;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<DetailTvSeriesBloc, TvSeriesState>(
        builder: (context, state) {
          if (state is TvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailHasData) {
            return SafeArea(
              child: DetailContent(
                state.tvSeriesDetail,
                tvseriesRecommendation,
                isAddedToWatchlist,
              ),
            );
          } else if (state is TvSeriesError) {
            return Center(
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
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(
      this.tvSeries, this.recommendations, this.isAddedWatchlist,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvSeriesBloc>()
                                      .add(OnSaveWatchlistTvSeries(tvSeries));
                                } else {
                                  context
                                      .read<WatchlistTvSeriesBloc>()
                                      .add(OnRemoveWatchlistTvSeries(tvSeries));
                                }

                                String message = '';

                                final state =
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .state;

                                if (state is TvSeriesWatchlistLoadData) {
                                  message = isAddedWatchlist
                                      ? WatchlistTvSeriesBloc
                                          .messageRemoveToWatchlist
                                      : WatchlistTvSeriesBloc
                                          .messageAddedToWatchlist;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? WatchlistTvSeriesBloc
                                          .messageAddedToWatchlist
                                      : WatchlistTvSeriesBloc
                                          .messageRemoveToWatchlist;
                                }

                                if (message ==
                                        WatchlistTvSeriesBloc
                                            .messageAddedToWatchlist ||
                                    message ==
                                        WatchlistTvSeriesBloc
                                            .messageRemoveToWatchlist) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          content: Text(
                                            message,
                                          )));
                                  //LOAD NEW STATUS
                                  BlocProvider.of<WatchlistTvSeriesBloc>(
                                          context)
                                      .add(OnLoadWatchlistStatusTvSeries(
                                          tvSeries.id));
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
                            const SizedBox(height: 10),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            Row(
                              children: [
                                Chip(
                                  label: Text(
                                      'Season : ${tvSeries.numberOfSeasons}'),
                                ),
                                const SizedBox(width: 10),
                                Chip(
                                  label: Text(
                                      'Episode : ${tvSeries.numberOfEpisodes}'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season = tvSeries.seasons[index];
                                  const imageUrl =
                                      'https://image.tmdb.org/t/p/w500';
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      child: Container(
                                        color: kOxfordBlue,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 120,
                                              width: 130,
                                              imageUrl: season.posterPath !=
                                                      null
                                                  ? '$imageUrl${season.posterPath}'
                                                  : '$imageUrl${tvSeries.posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 2),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${season.name}",
                                                    style: kSubtitle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                      "${season.episodeCount} Episode"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: tvSeries.seasons.length,
                              ),
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
                                  final tvSeries = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvSeriesDetailPage.ROUTE_NAME,
                                          arguments: tvSeries.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
                            )
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
}
