import 'package:albums/models/album_list.dart';
import 'package:albums/models/albums_local.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListViewModel {
  final AlbumsRepo albumsRepo;
  final Input input;
  late final Output output;

  AlbumListViewModel(this.input, {repo}): albumsRepo = repo ?? AlbumsRepo() {
    Stream<AlbumList> albumList = input.getList.startWith(null).flatMap((_) {
      return albumsRepo.getAlbums().map((AlbumsLocal locals) {
        if (DateTime.now().difference(locals.updatedDate).inMinutes > 2) {
          final al = AlbumList.fromDate(albums: locals.albums, date: locals.updatedDate);
          return al;
        } else {
          return AlbumList(albums: locals.albums);
        }
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
  final Stream<AlbumList> albumList;

  Output(this.albumList);
}
