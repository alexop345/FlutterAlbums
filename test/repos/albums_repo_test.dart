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

  test('hasNetwork is called', () {
    when(() => networkConnection.hasNetwork()).thenAnswer((_) => Future(() => false));
    when(() => sharedPrefRepo.getString(StorageKey.albums)).thenAnswer((_) => Stream.value(jsonEncode(localAlbums)));
    expect(albumsRepo.getAlbums(), emits(isA<AlbumsLocal>()));
    verify(() => networkConnection.hasNetwork()).called(1);
  });

  test('sharedPref getString is called', () {
    when(() => sharedPrefRepo.getString(StorageKey.albums)).thenAnswer((_) => Stream.value(jsonEncode(localAlbums)));
    expect(albumsRepo.getLocalAlbums(), emits(isA<AlbumsLocal>()));
    verify(() => sharedPrefRepo.getString(StorageKey.albums)).called(1);
  });


  test('sharedPref setString is called', () {
     when(() => sharedPrefRepo.setString(StorageKey.albums, jsonEncode(localAlbums.toJson()))).thenAnswer((_) => Stream.value(true));
    expect(albumsRepo.setLocalAlbums(localAlbums), emits(isA<AlbumsLocal>()));
    verify(() => sharedPrefRepo.setString(StorageKey.albums, jsonEncode(localAlbums.toJson()))).called(1);
  });
}
