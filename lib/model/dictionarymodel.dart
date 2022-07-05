// To parse this JSON data, do
//
//     final dictionaryModel = dictionaryModelFromJson(jsonString);

import 'dart:convert';

DictionaryModel dictionaryModelFromJson(String str) =>
    DictionaryModel.fromJson(json.decode(str));

String dictionaryModelToJson(DictionaryModel data) =>
    json.encode(data.toJson());

class DictionaryModel {
  DictionaryModel({
    this.definitions,
    this.word,
    this.pronunciation,
  });

  List<Definition>? definitions;
  String? word;
  String? pronunciation;

  factory DictionaryModel.fromJson(Map<String, dynamic> json) =>
      DictionaryModel(
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
        word: json["word"],
        pronunciation: json["pronunciation"],
      );

  Map<String, dynamic> toJson() => {
        "definitions": List<dynamic>.from(definitions!.map((x) => x.toJson())),
        "word": word,
        "pronunciation": pronunciation,
      };
}

class Definition {
  Definition({
    this.type,
    this.definition,
    this.example,
    this.imageUrl,
    this.emoji,
  });

  String? type;
  String? definition;
  String? example;
  String? imageUrl;
  String? emoji;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        type: json["type"],
        definition: json["definition"],
        example: json["example"],
        imageUrl: json["image_url"],
        emoji: json["emoji"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "definition": definition,
        "example": example,
        "image_url": imageUrl,
        "emoji": emoji,
      };
}
