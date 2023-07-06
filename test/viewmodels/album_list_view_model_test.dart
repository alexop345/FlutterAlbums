import 'package:albums/helper/date_helper.dart';
import 'package:albums/models/album.dart';
import 'package:albums/models/album_list_data.dart';
import 'package:albums/models/albums_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:albums/screens/album_list/album_list_view_model.dart';

import '../mocks/repo_mock.dart';
import '../mocks/service_mock.dart';

main() {
  late AlbumsRepo repo;
  late AlbumListViewModel viewModel;
  late int thresholdInMinutes;
  late DateHelper dateHelper;
  late DateTime now;

  setUp(() {
    repo = MockAlbumsRepo();
    dateHelper = MockDateHelper();
    now = DateTime.now();
    thresholdInMinutes = 2;
    viewModel = AlbumListViewModel(
      Input(BehaviorSubject<void>()),
      repo: repo,
      currentDate: now,
      durationThresholdInMinutes: thresholdInMinutes,
    );
    when(() => dateHelper.now).thenAnswer((_) => now);
  });

  test('albums should have been updated recently', () {
    final localAlbums = AlbumsLocal(
      updatedDate:
          dateHelper.now.subtract(Duration(minutes: thresholdInMinutes)),
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    expect(viewModel.output.albumList,
        emits(AlbumListData.recent(albums: localAlbums.albums)));
  });

  test('albums should have been updated minutes earlier', () {
    final localAlbums = AlbumsLocal(
      updatedDate: dateHelper.now.subtract(const Duration(minutes: 59)),
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    AlbumListData albumListData = AlbumListData.fromDate(
        albums: localAlbums.albums,
        oldDate: localAlbums.updatedDate,
        nowDate: now);
    expect(viewModel.output.albumList, emits(albumListData));
    expect(albumListData.lastUpdate!.period, 'm');
  });

  test('albums should have been updated hours earlier', () {
    final localAlbums = AlbumsLocal(
      updatedDate: dateHelper.now.subtract(const Duration(minutes: 61)),
      albums: [const Album(userId: 1, id: 1, title: 'Test album')],
    );

    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    AlbumListData albumListData = AlbumListData.fromDate(
        albums: localAlbums.albums,
        oldDate: localAlbums.updatedDate,
        nowDate: now);
    expect(viewModel.output.albumList, emits(albumListData));
    expect(albumListData.lastUpdate!.period, 'h');
  });

  test('reload', () {
    final localAlbums = AlbumsLocal(updatedDate: dateHelper.now, albums: []);
    when(() => repo.getAlbums()).thenAnswer((_) => Stream.value(localAlbums));
    expect(viewModel.output.showLoading, emitsInOrder([true, false]));
    viewModel.input.getList.add(null);
  });
}
