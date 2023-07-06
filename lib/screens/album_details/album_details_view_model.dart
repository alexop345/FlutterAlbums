import 'package:albums/models/album.dart';
import 'package:albums/models/albums_local.dart';
import 'package:albums/models/ui_model.dart';
import 'package:albums/repo/albums_repo.dart';
import 'package:rxdart/rxdart.dart';

class AlbumDetailsViewModel {
  final AlbumsRepo albumsRepo;
  final Input input;
  late final Output output;

  AlbumDetailsViewModel(this.input, {repo})
      : albumsRepo = repo ?? AlbumsRepo() {
    Stream<UIModel<Album>> album = input.getAlbum.flatMap((id) {
      return Stream.fromFuture(Future.delayed(const Duration(seconds: 2)))
          .flatMap((value) {
        return albumsRepo.getAlbums().flatMap((AlbumsLocal locals) {
          Album al = locals.albums.firstWhere((album) => album.id == id);
          return Stream.value(UIModel.ok(al));
        }).onErrorResume((error, stackTrace) {
          return Stream.value(UIModel.error(error));
        });
      }).startWith(UIModel.loading(null));
    });

    output = Output(album);
  }
}

class Input {
  final Subject<int> getAlbum;

  Input(this.getAlbum);
}

class Output {
  final Stream<UIModel<Album>> album;

  Output(this.album);
}
