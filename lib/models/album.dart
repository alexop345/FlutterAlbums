import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  static String encode(List<Album> albums) => json.encode(
        albums.map<Map<String, dynamic>>((album) => album.toJson()).toList(),
      );

  static List<Album> decode(String albums) =>
      (json.decode(albums) as List<dynamic>)
          .map<Album>((item) => Album.fromJson(item))
          .toList();
}
