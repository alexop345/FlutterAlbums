import 'dart:convert';

import 'package:albums/models/album.dart';
import 'package:albums/models/albums_local.dart';
import 'package:albums/networking/albums_service.dart';
import 'package:albums/networking/enpoint_structure.dart';
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

  Stream<AlbumsLocal> getAlbums() {
    return Stream.fromFuture(hasNetwork(urlDomain)).flatMap((bool isNetwork) {
      if (isNetwork) {
        return Stream.fromFuture(albumsService.getAlbums())
            .flatMap((List<Album> albums) {
          AlbumsLocal albumsLocal = AlbumsLocal(
              updatedDate: DateTime.now().millisecondsSinceEpoch,
              albums: albums);
          return setLocalAlbums(albumsLocal).map((event) {
            return albumsLocal;
          });
        });
      }
      return getLocalAlbums().map((value) {
        return value;
      });
    });
  }

  Stream<AlbumsLocal> setLocalAlbums(AlbumsLocal albums) {
    return sharedPrefRepo
        .setString(StorageKey.albums, albums.toJson().toString())
        .map((value) => albums);
  }

  Stream<AlbumsLocal> getLocalAlbums() {
    return sharedPrefRepo.getString(StorageKey.albums).map((value) {
      return value != null
          ? AlbumsLocal.fromJson(jsonDecode(value))
          : const AlbumsLocal(updatedDate: 0, albums: []);
    });
  }
}
