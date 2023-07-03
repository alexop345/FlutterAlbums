import 'dart:convert';

import 'package:albums/models/album.dart';
import 'package:albums/models/albums_local.dart';
import 'package:albums/networking/albums_service.dart';
import 'package:albums/networking/enpoint_structure.dart';
import 'package:albums/networking/network_connection.dart';
import 'package:albums/repo/shared_pref_repo.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class AlbumsRepo {
  final AlbumsService albumsService;
  final SharedPrefRepo sharedPrefRepo;
  final NetworkConnection networkConnection;
  final DateTime now;

  AlbumsRepo({albumsService, sharedPrefRepo, networkConnection, currentDate})
      : albumsService = albumsService ??
            AlbumsService(Dio(BaseOptions(contentType: "application/json"))),
        sharedPrefRepo = sharedPrefRepo ?? SharedPrefRepo(),
        networkConnection =
            networkConnection ?? const NetworkConnection(url: urlDomain),
        now = currentDate ?? DateTime.now();

  Stream<AlbumsLocal> getAlbums() {
    return Stream.fromFuture(networkConnection.hasNetwork())
        .flatMap((bool isNetwork) {
      if (isNetwork) {
        return Stream.fromFuture(albumsService.getAlbums())
            .flatMap((List<Album> albums) {
          AlbumsLocal albumsLocal =
              AlbumsLocal(updatedDate: now, albums: albums);
          return setLocalAlbums(albumsLocal).map((event) {
            return albumsLocal;
          });
        });
      }
      return getLocalAlbums();
    });
  }

  Stream<AlbumsLocal> setLocalAlbums(AlbumsLocal albums) {
    return sharedPrefRepo
        .setString(StorageKey.albums, jsonEncode(albums.toJson()))
        .map((value) => albums);
  }

  Stream<AlbumsLocal> getLocalAlbums() {
    return sharedPrefRepo.getString(StorageKey.albums).map((value) {
      return value != null
          ? AlbumsLocal.fromJson(jsonDecode(value))
          : AlbumsLocal(updatedDate: now, albums: []);
    });
  }
}
