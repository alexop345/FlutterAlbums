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

  Stream<Map<int, List<Album>>> getAlbums() {
    return Stream.fromFuture(hasNetwork(AlbumsService.urlDomain))
        .flatMap((bool isNetwork) {
      if (isNetwork) {
        return Stream.fromFuture(albumsService.getAlbums())
            .flatMap((List<Album> albums) {
          return setAlbums(albums).flatMap((event) {
            return setAlbumsDateUpdated().map((event) {
              return {event: albums};
            });
          });
        });
      }
      return sharedPrefRepo.getString(StorageKey.albums).flatMap((value) {
        return getAlbumsDateUpdated().map((event) {
          return {event: value != null ? Album.decode(value) : []};
        });
      });
    });
  }

  Stream<List<Album>> setAlbums(List<Album> albums) {
    return sharedPrefRepo
        .setString(StorageKey.albums, Album.encode(albums))
        .map((value) => albums);
  }

  Stream<int> setAlbumsDateUpdated() {
    int updated = DateTime.now().millisecondsSinceEpoch;
    return sharedPrefRepo
        .setString(StorageKey.albumsDateUpdated, updated.toString())
        .map((event) {
      return updated;
    });
  }

  Stream<int> getAlbumsDateUpdated() {
    return sharedPrefRepo.getString(StorageKey.albumsDateUpdated).map((event) {
      if (event != null) {
        return int.parse(event);
      }
      return DateTime.now().millisecondsSinceEpoch;
    });
  }
}
