import 'package:equatable/equatable.dart';

class MovieResponse {
  final List<Movie> movies;
  final int totalResults;
  final bool hasError;
  final String error;

  MovieResponse(this.movies, this.totalResults, this.hasError, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies =
            (json["results"] as List).map((i) => Movie.fromJson(i)).toList(),
        totalResults = json["total_results"],
        hasError = false,
        error = "";

  MovieResponse.withError(String errorValue)
      : movies = [],
        totalResults = 0,
        hasError = true,
        error = errorValue;
}

class Movie extends Equatable {
  final int id;
  final num popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final num rating;
  final String releaseDate;

  const Movie(this.id, this.popularity, this.title, this.backPoster,
      this.poster, this.overview, this.rating, this.releaseDate);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"] ?? 0,
        title = json["title"] ?? "",
        backPoster = json["backdrop_path"] ?? "",
        poster = json["poster_path"] ?? "",
        overview = json["overview"] ?? "",
        rating = json["vote_average"] ?? 0.0,
        releaseDate = json["release_date"] ?? "";

  @override
  List<Object> get props =>
      [id, popularity, title, backPoster, poster, overview, rating];

  static const empty = Movie(0, 0, "", "", "", "", 0, "");
}
