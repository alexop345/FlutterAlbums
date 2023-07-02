import 'package:albums/models/album.dart';
import 'package:albums/models/album_list.dart';
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

  setUp(() {
    repo = MockAlbumsRepo();
    viewModel = AlbumListViewModel(
      Input(BehaviorSubject<void>()),
      repo: repo,
    );
  });

  test('fetch albums', () {
    final localAlbums = AlbumsLocal(
      updatedDate: DateTime.now(),
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    expect(viewModel.output.albumList, emits(isA<AlbumList>()));
  });
}
