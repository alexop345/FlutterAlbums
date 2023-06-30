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

  AlbumsLocal localAlbums = AlbumsLocal(updatedDate: DateTime.now(), albums: const [Album(userId: 1, id: 1, title: 'Test title')]);

  setUp(() {
    sharedPrefRepo = MockSharedPrefRepo();
    albumsService = MockAlbumsService();
    networkConnection = MockNetworkConnection();
    albumsRepo = AlbumsRepo(
      albumsService: albumsService,
      sharedPrefRepo: sharedPrefRepo,
      networkConnection: networkConnection,
    );
  });

  test('test', () {
    when(() => networkConnection.hasNetwork()).thenAnswer((_) => Future(() => false));
    when(() => sharedPrefRepo.getString(StorageKey.albums)).thenAnswer((_) => Stream.value(jsonEncode(localAlbums)));
    expect(albumsRepo.getAlbums(), emits(localAlbums));
  });
}
