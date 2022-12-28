import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_tvseries/presentation/bloc/tv_series_bloc.dart';
import 'package:module_tvseries/presentation/widgets/tv_card_list.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const routeName = '/top-rated-tv';

  const TopRatedTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedTvSeriesBloc>().add(OnTopRatedTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TvSeriesState>(
          builder: (context, state) {
            if (state is TvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.tvseries[index];
                  return TvSeriesCard(tvseries);
                },
                itemCount: state.tvseries.length,
              );
            } else if (state is TvSeriesError) {
              return Center(
                key: const Key("Error message"),
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
