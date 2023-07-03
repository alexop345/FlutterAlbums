import 'package:albums/models/album_list_data.dart';
import 'package:albums/models/albums_local.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListViewModel {
  late final AlbumsRepo albumsRepo;
  final Input input;
  late final Output output;
  late final DateTime now;
  late final int threshold;

  AlbumListViewModel(this.input, {repo, currentDate, durationThreshold}) {
    now = currentDate ?? DateTime.now();
    albumsRepo = repo ?? AlbumsRepo(currentDate: now);
    threshold = durationThreshold ?? 2;

    Stream<AlbumListData> albumList =
        input.getList.startWith(null).flatMap((_) {
      return albumsRepo.getAlbums().map((AlbumsLocal locals) {
        return now.difference(locals.updatedDate).inMinutes > threshold
            ? AlbumListData.fromDate(
                albums: locals.albums,
                date: locals.updatedDate,
                now: now,
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
