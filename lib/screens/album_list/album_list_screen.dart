import 'package:albums/models/album.dart';
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
      body: StreamBuilder<Map<int, List<Album>>>(
        stream: _albumListViewModel.output.albumList,
        builder: (ctx, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            final data = snapshot.data;
            final updatedTime = data!.keys.toList()[0];
            final List<Album> albums = data[updatedTime] ?? [];
            return (albums.isNotEmpty)
                ? Column(
                    children: [
                      Text(
                        'Results updated: ${updatedTime}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: AppDimens.containerDefaultSpacingAll,
                          itemCount: albums.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: AppDimens.bottomDefaultSpacing,
                              child: AlbumListItemWidget(albums[index]),
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
