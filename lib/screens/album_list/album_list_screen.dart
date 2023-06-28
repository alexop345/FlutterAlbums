import 'package:albums/models/album.dart';
import 'package:albums/screens/album_list/album_list_view_model.dart';
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
      body: StreamBuilder<List<Album>>(
        stream: _albumListViewModel.output.albumList,
        builder: (ctx, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            final List<Album> albums = snapshot.data ?? [];
            return (albums.isNotEmpty)
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AlbumListItemWidget(albums[index]),
                      );
                    },
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
