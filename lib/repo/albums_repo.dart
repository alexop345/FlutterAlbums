import 'package:albums/models/album.dart';
import 'package:albums/networking/albums_service.dart';
import 'package:dio/dio.dart';

class AlbumsRepo {
  Stream<List<Album>> getAlbums() {
    final albumsService =
        AlbumsService(Dio(BaseOptions(contentType: "application/json")));
    return Stream.fromFuture(albumsService.getAlbums());
  }
}
