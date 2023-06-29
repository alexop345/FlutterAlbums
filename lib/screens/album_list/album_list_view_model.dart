import 'package:albums/models/albums_local.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListViewModel {
  final AlbumsRepo albumsRepo;
  final Input input;
  late final Output output;

  AlbumListViewModel(this.input, {repo}): albumsRepo = repo ?? AlbumsRepo() {
    Stream<AlbumsLocal> albumList = input.getList.startWith(null).flatMap((_) {
      return albumsRepo.getAlbums();
    });

    output = Output(albumList);
  }
}

class Input {
  final Subject<void> getList;

  Input(this.getList);
}

class Output {
  final Stream<AlbumsLocal> albumList;

  Output(this.albumList);
}
