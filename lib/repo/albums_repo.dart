import 'package:albums/models/album.dart';
import 'package:albums/networking/albums_service.dart';
import 'package:albums/networking/network_availability.dart';
import 'package:albums/repo/shared_pref_repo.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class AlbumsRepo {
  final AlbumsService albumsService;
  final SharedPrefRepo sharedPrefRepo;

  AlbumsRepo({albumsService, sharedPrefRepo})
      : albumsService = albumsService ??
            AlbumsService(Dio(BaseOptions(contentType: "application/json"))),
        sharedPrefRepo = sharedPrefRepo ?? SharedPrefRepo();

  Stream<List<Album>> getAlbums() {
    return Stream.fromFuture(hasNetwork(AlbumsService.urlDomain))
        .flatMap((bool isNetwork) {
      if (isNetwork) {
        return Stream.fromFuture(albumsService.getAlbums())
            .flatMap((List<Album> albums) {
          return setAlbums(albums).map((event) {
            return albums;
          });
        });
      }
      return sharedPrefRepo.getString(StorageKey.albums).map((value) {
        return value != null ? Album.decode(value) : [];
      });
    });
  }

  Stream<List<Album>> setAlbums(List<Album> albums) {
    return sharedPrefRepo
        .setString(StorageKey.albums, Album.encode(albums))
        .map((value) => albums);
  }
}
