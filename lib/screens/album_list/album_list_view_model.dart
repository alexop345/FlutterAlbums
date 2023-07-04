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
  late final DateHelper helper;

  AlbumListViewModel(this.input, {repo, currentDate, durationThresholdInMinutes, dateHelper}) {
    albumsRepo = repo ?? AlbumsRepo();
    thresholdInMinutes = durationThresholdInMinutes ?? 2;
    helper = dateHelper ?? DateHelper();

    Stream<AlbumListData> albumList =
        input.getList.startWith(null).flatMap((_) {
      return albumsRepo.getAlbums().map((AlbumsLocal locals) {
        return helper.now.difference(locals.updatedDate).inMinutes > thresholdInMinutes
            ? AlbumListData.fromDate(
                albums: locals.albums,
                oldDate: locals.updatedDate,
                nowDate: helper.now,
              )
            : AlbumListData.recent(albums: locals.albums);
      });
    });

    output = Output(albumList);
  }
}

class Input {
  final Subject<void> getList;

  Input(this.getList);
}

class Output {
  final Stream<AlbumListData> albumList;

  Output(this.albumList);
}
