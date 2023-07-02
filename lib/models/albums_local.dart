import 'package:albums/models/album.dart';
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
}
