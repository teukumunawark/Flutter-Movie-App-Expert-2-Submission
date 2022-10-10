import 'package:equatable/equatable.dart';
import 'package:module_movies/data/models/genre_model.dart';

import '../../domain/entities/tv_series_detail.dart';
import 'next_episode_to_air_model.dart';
import 'season_model.dart';

class TvDetailResponse extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String lastAirDate;
  final NextEpisodeToAirModel? lastEpisodeToAir;
  final String name;
  final NextEpisodeToAirModel? nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  const TvDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) {
    return TvDetailResponse(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      episodeRunTime: List<int>.from(json["episode_run_time"].map((e) => e)),
      firstAirDate: json['first_air_date'],
      genres: List<GenreModel>.from(
          json["genres"].map((e) => GenreModel.fromJson(e))),
      id: json['id'],
      lastAirDate: json['last_air_date'],
      lastEpisodeToAir: json['last_episode_to_air'] == null
          ? null
          : NextEpisodeToAirModel.fromJson(json['last_episode_to_air']),
      name: json['name'],
      nextEpisodeToAir: json['next_episode_to_air'] == null
          ? null
          : NextEpisodeToAirModel.fromJson(json['next_episode_to_air']),
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: (json['popularity'])?.toDouble(),
      posterPath: json['poster_path'],
      seasons: List<SeasonModel>.from(
          json["seasons"].map((x) => SeasonModel.fromJson(x))).toList(),
      status: json['status'],
      tagline: json['tagline'],
      type: json['type'],
      voteAverage: (json['vote_average'])?.toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'episode_run_time': episodeRunTime,
        'first_air_date': firstAirDate,
        'genres': genres.map((e) => e.toJson()).toList(),
        'id': id,
        'last_air_date': lastAirDate,
        'last_episode_to_air': lastEpisodeToAir!.toJson(),
        'name': name,
        'next_episode_to_air': nextEpisodeToAir!.toJson(),
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'original_name': originalName,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'status': status,
        'tagline': tagline,
        'type': type,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: genres.map((e) => e.toEntity()).toList(),
      id: id,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir!.toEntity(),
      name: name,
      nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      seasons: seasons.map((e) => e.toEntity()).toList(),
      status: status,
      tagline: tagline,
      type: type,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props {
    return [
      adult,
      backdropPath,
      episodeRunTime,
      firstAirDate,
      genres,
      id,
      lastAirDate,
      lastEpisodeToAir,
      name,
      nextEpisodeToAir,
      numberOfEpisodes,
      numberOfSeasons,
      originalName,
      overview,
      popularity,
      posterPath,
      seasons,
      status,
      tagline,
      type,
      voteAverage,
      voteCount,
    ];
  }
}
