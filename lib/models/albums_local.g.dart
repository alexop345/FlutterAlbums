// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumsLocal _$AlbumsLocalFromJson(Map<String, dynamic> json) => AlbumsLocal(
      updatedDate: DateTime.parse(json['updatedDate'] as String),
      albums: (json['albums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumsLocalToJson(AlbumsLocal instance) =>
    <String, dynamic>{
      'updatedDate': instance.updatedDate.toIso8601String(),
      'albums': instance.albums,
    };
