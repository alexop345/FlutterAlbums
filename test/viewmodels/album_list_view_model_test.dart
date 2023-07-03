import 'package:albums/models/album.dart';
import 'package:albums/models/album_list_data.dart';
import 'package:albums/models/albums_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:albums/screens/album_list/album_list_view_model.dart';

import '../mocks/repo_mock.dart';

main() {
  late AlbumsRepo repo;
  late AlbumListViewModel viewModel;
  late DateTime now;
  late int threshold;

  setUp(() {
    repo = MockAlbumsRepo();
    now = DateTime(2023, 5, 5, 10, 10);
    threshold = 2;
    viewModel = AlbumListViewModel(
      Input(BehaviorSubject<void>()),
      repo: repo,
      currentDate: now,
      durationThreshold: threshold,
    );
  });

  test('albums should have been updated recently', () {
    final localAlbums = AlbumsLocal(
      updatedDate: now.subtract(Duration(minutes: threshold)),
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    expect(viewModel.output.albumList, emits(AlbumListData.recent(albums: localAlbums.albums)));
  });

  test('albums should have been updated minutes earlier', () {
    final localAlbums = AlbumsLocal(
      updatedDate: now.subtract(const Duration(minutes: 59)),
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    AlbumListData albumListData = AlbumListData.fromDate(albums: localAlbums.albums, date: localAlbums.updatedDate, now: now);
    expect(viewModel.output.albumList, emits(albumListData));
    expect(albumListData.lastUpdate!.period, 'm');
  });

  test('albums should have been updated hours earlier', () {
    final localAlbums = AlbumsLocal(
      updatedDate: now.subtract(const Duration(minutes: 61)),
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    AlbumListData albumListData = AlbumListData.fromDate(albums: localAlbums.albums, date: localAlbums.updatedDate, now: now);
    expect(viewModel.output.albumList, emits(albumListData));
    expect(albumListData.lastUpdate!.period, 'h');
  });
}
