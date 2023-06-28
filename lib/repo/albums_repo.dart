import 'package:albums/models/album.dart';
import 'package:albums/networking/albums_service.dart';
import 'package:dio/dio.dart';

class AlbumsRepo {
  final AlbumsService albumsService;

  AlbumsRepo({albumsService})
      : albumsService = albumsService ??
            AlbumsService(Dio(BaseOptions(contentType: "application/json")));

  Stream<List<Album>> getAlbums() {
    return Stream.fromFuture(albumsService.getAlbums());
  }
}
