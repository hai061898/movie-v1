import 'package:equatable/equatable.dart';

class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse(this.genres, this.error);

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
        error = "";

  GenreResponse.withError(String errorValue)
      : genres = [],
        error = errorValue;
}

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre(this.id, this.name);

  Genre.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"] ?? "";

  @override
  List<Object> get props => [id, name];

  static const empty = Genre(0, "");
}
