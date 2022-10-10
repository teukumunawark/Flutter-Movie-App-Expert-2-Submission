import 'package:module_movies/domain/entities/genre.dart';
import 'package:module_tvseries/data/models/tv_series_table.dart';
import 'package:module_tvseries/domain/entities/next_episode_to_air.dart';
import 'package:module_tvseries/domain/entities/season.dart';
import 'package:module_tvseries/domain/entities/tv_series.dart';
import 'package:module_tvseries/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
  backdropPath: 'backdropPath',
  firstAirDate: DateTime.parse('2000-09-11 11:11:11.591918'),
  genreIds: const [1, 2, 3],
  id: 1,
  name: 'name',
  originCountry: const ['originCountry', 'originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 2,
  posterPath: 'posterPath',
  voteAverage: 123,
  voteCount: 456,
);
final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/pdfCr8W0wBCpdjbZXSxnKhZtosP.jpg",
  episodeRunTime: const [60],
  firstAirDate: "2022-09-01",
  genres: [
    Genre(
      id: 10765,
      name: "Sci-Fi & Fantasy",
    ),
    Genre(
      id: 10759,
      name: "Action & Adventure",
    ),
    Genre(
      id: 18,
      name: "Drama",
    ),
  ],
  id: 1,
  lastAirDate: "2022-09-22",
  lastEpisodeToAir: const NextEpisodeToAir(
    id: 3894853,
    airDate: "2022-09-22",
    episodeNumber: 5,
    name: "Partings",
    productionCode: '',
    runtime: 72,
    seasonNumber: 1,
    showId: 84773,
    stillPath: "/jLxeqABrd8nqKq6aLa7wPIszRMU.jpg",
    voteAverage: 6.722,
    voteCount: 18,
    overview:
        "Nori questions her instincts. Elrond struggles to stay true to his oath. Halbrand weighs his destiny. The Southlanders brace for attack.",
  ),
  name: "The Lord of the Rings: The Rings of Power",
  nextEpisodeToAir: const NextEpisodeToAir(
    id: 3894854,
    airDate: "2022-09-29",
    episodeNumber: 6,
    name: "Episode 6",
    productionCode: '',
    runtime: 0,
    seasonNumber: 1,
    showId: 84773,
    stillPath: "/hXhii7h89fpK6VlJT6R8OUbwCTT.jpg",
    voteAverage: 0.0,
    voteCount: 0,
    overview: "",
  ),
  numberOfEpisodes: 8,
  numberOfSeasons: 1,
  originalName: "The Lord of the Rings: The Rings of Power",
  overview:
      "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
  popularity: 5346.195,
  posterPath: "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
  seasons: [
    Season(
      airDate: DateTime.parse("2022-09-01"),
      episodeCount: 8,
      id: 114041,
      name: "Season 1",
      overview: "",
      posterPath: "/K88yWEarvuce6SJIWXZM1X7GXf.jpg",
      seasonNumber: 1,
    ),
  ],
  status: "Returning Series",
  tagline: "Journey to Middle-earth.",
  type: "Scripted",
  voteAverage: 7.673,
  voteCount: 825,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: "The Lord of the Rings: The Rings of Power",
  posterPath: "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
  overview:
      "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
);

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: "The Lord of the Rings: The Rings of Power",
  posterPath: "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
  overview:
      "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
);

final testTvSeriesMap = {
  'id': 1,
  'name': "The Lord of the Rings: The Rings of Power",
  'posterPath': "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
  'overview':
      "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
};
