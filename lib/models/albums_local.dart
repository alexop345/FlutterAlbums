import 'package:albums/models/album.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'albums_local.g.dart';

@JsonSerializable()
class AlbumsLocal {
  final DateTime updatedDate;
  final List<Album> albums;

  const AlbumsLocal({
    required this.updatedDate,
    required this.albums,
  });

  factory AlbumsLocal.fromJson(Map<String, dynamic> json) => _$AlbumsLocalFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumsLocalToJson(this);


  @override
  int get hashCode => updatedDate.hashCode ^ albums.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumsLocal &&
          updatedDate == other.updatedDate &&
          listEquals(albums, other.albums);
}
