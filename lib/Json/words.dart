// To parse this JSON data, do
//
//     final words = wordsFromJson(jsonString);

import 'dart:convert';

Words wordsFromJson(String str) => Words.fromJson(json.decode(str));

String wordsToJson(Words data) => json.encode(data.toJson());

class Words {
    Words({
        this.joke,
    });

    String? joke;

    factory Words.fromJson(Map<String, dynamic> json) => Words(
        joke: json["joke"],
    );

    Map<String, dynamic> toJson() => {
        "joke": joke,
    };
}
