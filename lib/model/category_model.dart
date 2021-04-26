// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

List<Data> dataFromJson(String str) => List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
    Data({
        this.title,
        this.image,
        this.rating,
        this.releaseYear,
        this.genre,
    });

    String title;
    String image;
    double rating;
    int releaseYear;
    List<String> genre;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        image: json["image"],
        rating: json["rating"].toDouble(),
        releaseYear: json["releaseYear"],
        genre: List<String>.from(json["genre"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "rating": rating,
        "releaseYear": releaseYear,
        "genre": List<dynamic>.from(genre.map((x) => x)),
    };
}
