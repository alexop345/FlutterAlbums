import 'package:albums/models/albums_local.dart';
import 'package:albums/screens/album_list/album_list_view_model.dart';
import 'package:albums/themes/app_diments.dart';
import 'package:albums/widgets/album_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() {
    return _AlbumListScreenState();
  }
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  late AlbumListViewModel _albumListViewModel;

  @override
  void initState() {
    super.initState();
    _albumListViewModel = AlbumListViewModel(Input(BehaviorSubject<void>()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: StreamBuilder<AlbumsLocal>(
        stream: _albumListViewModel.output.albumList,
        builder: (ctx, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            final AlbumsLocal albumsLocal = snapshot.data!;
            return (albumsLocal.albums.isNotEmpty)
                ? Column(
                    children: [
                      Text(
                        'Results updated: ${albumsLocal.updatedDate}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: AppDimens.containerDefaultSpacingAll,
                          itemCount: albumsLocal.albums.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: AppDimens.bottomDefaultSpacing,
                              child: AlbumListItemWidget(albumsLocal.albums[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text('No albums available!'),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
