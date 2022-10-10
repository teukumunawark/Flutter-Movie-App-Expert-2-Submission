import 'package:equatable/equatable.dart';
import 'package:module_movies/data/models/movie_model.dart';

class MovieResponse extends Equatable {
  final List<MovieModel> movieList;

  // ignore: prefer_const_constructors_in_immutables
  MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movieList: List<MovieModel>.from((json["results"] as List)
            .map((x) => MovieModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
