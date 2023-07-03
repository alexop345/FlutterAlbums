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
  late DateTime nowDate;
  late DateTime oldDate;

  setUp(() {
    repo = MockAlbumsRepo();
    nowDate = DateTime.now();
    oldDate = DateTime.utc(2023, 5, 5);
    viewModel = AlbumListViewModel(
      Input(BehaviorSubject<void>()),
      repo: repo,
      currentDate: nowDate,
    );
  });

  test('albums should have been updated recently', () {
    final localAlbums = AlbumsLocal(
      updatedDate: nowDate,
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    expect(viewModel.output.albumList, emits(AlbumListData.recent(albums: localAlbums.albums)));
  });

  test('albums should have been updated earlier', () {
    final localAlbums = AlbumsLocal(
      updatedDate: oldDate,
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    expect(viewModel.output.albumList, emits(AlbumListData.fromDate(albums: localAlbums.albums, date: localAlbums.updatedDate)));
  });
}
