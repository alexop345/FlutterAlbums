import 'package:albums/models/album.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListViewModel {
  final AlbumsRepo albumsRepo;
  final Input input;
  late final Output output;

  AlbumListViewModel(this.input, {repo}): albumsRepo = repo ?? AlbumsRepo() {
    Stream<Map<int, List<Album>>> albumList = input.getList.startWith(null).flatMap((_) {
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
  final Stream<Map<int, List<Album>>> albumList;

  Output(this.albumList);
}
