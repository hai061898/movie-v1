import 'package:equatable/equatable.dart';

class CastResponse {
  final List<Cast> casts;
  final String error;

  CastResponse(this.casts, this.error);

  CastResponse.fromJson(Map<String, dynamic> json)
      : casts = (json["cast"] as List).map((i) => Cast.fromJson(i)).toList(),
        error = "";

  CastResponse.withError(String errorValue)
      : casts = [],
        error = errorValue;
}

class Cast extends Equatable {
  final int id;
  final String character;
  final String name;
  final String img;

  const Cast(this.id, this.character, this.name, this.img);

  Cast.fromJson(Map<String, dynamic> json)
      : id = json["cast_id"],
        character = json["character"] ?? "",
        name = json["name"] ?? "",
        img = json["profile_path"] ?? "";

  @override
  List<Object> get props => [id, character, name, img];

  static const empty = Cast(0, "", "", "");
}
