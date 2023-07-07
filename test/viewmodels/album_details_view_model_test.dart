import 'package:albums/models/album.dart';
import 'package:albums/models/ui_model.dart';
import 'package:albums/screens/album_details/album_details_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:albums/repo/albums_repo.dart';

import '../mocks/repo_mock.dart';

main() {
  late AlbumsRepo repo;
  late AlbumDetailsViewModel viewModel;

  setUp(() {
    repo = MockAlbumsRepo();
    viewModel = AlbumDetailsViewModel(
      Input(BehaviorSubject<int>()),
      repo: repo,
    );
  });

  test('should emit in order loading and album', () {
    const Album album = Album(userId: 1, id: 1, title: 'Test');
    when(() => repo.getAlbumById(album.id)).thenAnswer((_) => Stream.value(album));
    expect(
      viewModel.output.album,
      emitsInOrder([
        UIModel.loading(null),
        UIModel.ok(album),
      ]),
    );
    viewModel.input.getAlbum.add(album.id);
  });

  test('should emit in order loading and error', () {
    Exception e = Exception('Exception from getAlbumById thrown');
    when(() => repo.getAlbumById(1)).thenAnswer((_) => Stream.error(e));
    expect(
      viewModel.output.album,
      emitsInOrder([
        UIModel.loading(null),
        UIModel.error(e),
      ]),
    );
    viewModel.input.getAlbum.add(1);
  });
}
