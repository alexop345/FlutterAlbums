import 'dart:convert';

import 'package:albums/models/album.dart';
import 'package:albums/models/albums_local.dart';
import 'package:albums/networking/albums_service.dart';
import 'package:albums/networking/network_connection.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:albums/repo/shared_pref_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/service_mock.dart';
import '../mocks/repo_mock.dart';

main() {
  late AlbumsRepo albumsRepo;
  late SharedPrefRepo sharedPrefRepo;
  late AlbumsService albumsService;
  late NetworkConnection networkConnection;
  late DateTime now;

  setUp(() {
    sharedPrefRepo = MockSharedPrefRepo();
    albumsService = MockAlbumsService();
    networkConnection = MockNetworkConnection();
    now = DateTime.now();
    albumsRepo = AlbumsRepo(
      albumsService: albumsService,
      sharedPrefRepo: sharedPrefRepo,
      networkConnection: networkConnection,
      currentDate: now,
    );
  });

  test('should emit value from shared preferences if is not null', () {
    AlbumsLocal localAlbums = AlbumsLocal(
      updatedDate: now,
      albums: const [Album(userId: 1, id: 1, title: 'Test title')],
    );
    when(() => networkConnection.hasNetwork())
        .thenAnswer((_) => Future(() => false));
    when(() => sharedPrefRepo.getString(StorageKey.albums))
        .thenAnswer((_) => Stream.value(jsonEncode(localAlbums)));

    expect(albumsRepo.getAlbums(), emits(localAlbums));
  });

  test('should emit empty value if shared preferences returns null', () {
    when(() => networkConnection.hasNetwork())
        .thenAnswer((_) => Future(() => false));
    when(() => sharedPrefRepo.getString(StorageKey.albums))
        .thenAnswer((_) => Stream.value(null));

    expect(albumsRepo.getAlbums(),
        emits(AlbumsLocal(updatedDate: now, albums: [])));
  });

  test('should emit value from service', () {
    AlbumsLocal localAlbums = AlbumsLocal(
      updatedDate: now,
      albums: const [Album(userId: 1, id: 1, title: 'Test title')],
    );
    when(() => networkConnection.hasNetwork())
        .thenAnswer((_) => Future(() => true));
    when(() => albumsService.getAlbums())
        .thenAnswer((_) => Future(() => localAlbums.albums));
    when(() => sharedPrefRepo.setString(StorageKey.albums, jsonEncode(localAlbums.toJson())))
        .thenAnswer((_) => Stream.value(true));

    expect(albumsRepo.getAlbums(), emits(localAlbums));
  });
}
