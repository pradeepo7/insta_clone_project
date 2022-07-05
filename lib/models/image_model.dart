// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ImageModel> imageModelFromJson(String str) => List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  ImageModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final int id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: int.parse(json["id"]),
    author: json["author"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    downloadUrl: json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "author": author,
    "width": width,
    "height": height,
    "url": url,
    "download_url": downloadUrl,
  };
}
