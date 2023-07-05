import 'package:albums/helper/date_helper.dart';
import 'package:albums/models/album_list_data.dart';
import 'package:albums/models/albums_local.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListViewModel {
  late final AlbumsRepo albumsRepo;
  final Input input;
  late final Output output;
  late final int thresholdInMinutes;

  AlbumListViewModel(this.input,
      {repo, currentDate, durationThresholdInMinutes}) {
    albumsRepo = repo ?? AlbumsRepo();
    thresholdInMinutes = durationThresholdInMinutes ?? 1;

    Stream<AlbumListData> albumList = input.getList.startWith(null).flatMap(
      (_) {
        input.showLoading.add(true);
        return Stream.fromFuture(Future.delayed(Duration(seconds: 2)))
            .flatMap((value) {
          DateHelper helper = DateHelper();
          return albumsRepo.getAlbums().map(
            (AlbumsLocal locals) {
              input.showLoading.add(false);
              return helper.now.difference(locals.updatedDate).inMinutes >
                      thresholdInMinutes
                  ? AlbumListData.fromDate(
                      albums: locals.albums,
                      oldDate: locals.updatedDate,
                      nowDate: helper.now,
                    )
                  : AlbumListData.recent(albums: locals.albums);
            },
          );
        });
      },
    );

    Stream<bool> showLoading = input.showLoading.map((bool value) {
      return value;
    });

    output = Output(albumList, showLoading);
  }
}

class Input {
  final Subject<void> getList;
  final Subject<bool> showLoading;

  Input(this.getList, this.showLoading);
}

class Output {
  final Stream<AlbumListData> albumList;
  final Stream<bool> showLoading;

  Output(this.albumList, this.showLoading);
}
