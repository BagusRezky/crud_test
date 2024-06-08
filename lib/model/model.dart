import 'dart:convert';

List<Model> modelFromJson(String str) =>
    List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
  String id;
  String name;
  int age;
  String colour;

  Model({required this.id, required this.name, required this.age, required this.colour});

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["_id"], name: json["name"], age: json["age"], colour: json["colour"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "colour": colour,
  };

  Map<String, dynamic> toJsonWithoutId() => {
    "name": name,
    "age": age,
    "colour": colour,
  };
}
