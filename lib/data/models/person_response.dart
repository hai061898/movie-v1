import 'package:equatable/equatable.dart';

class PersonResponse {
  final List<Person> persons;
  final String error;

  PersonResponse(this.persons, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons =
            (json["results"] as List).map((i) => Person.fromJson(i)).toList(),
        error = "";

  PersonResponse.withError(String errorValue)
      : persons = [],
        error = errorValue;
}

class Person extends Equatable {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;

  const Person(
      this.id, this.popularity, this.name, this.profileImg, this.known);

  Person.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profile_path"],
        known = json["known_for_department"];

  @override
  List<Object> get props => [id, popularity, name, profileImg, known];

  static const empty = Person(0, 0.0, "", "", "");
}
