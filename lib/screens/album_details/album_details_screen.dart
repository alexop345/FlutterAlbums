import 'package:albums/models/album.dart';
import 'package:albums/models/ui_model.dart';
import 'package:albums/screens/album_details/album_details_view_model.dart';
import 'package:albums/widgets/common/favorites_button.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final int id;
  final String title;

  const AlbumDetailsScreen(this.id, {super.key, required this.title});

  @override
  State<AlbumDetailsScreen> createState() {
    return _AlbumDetailsScreenState();
  }
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  late AlbumDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel =
        AlbumDetailsViewModel(Input(BehaviorSubject<int>.seeded(widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [
          FavoritesButton(),
        ],
      ),
      body: StreamBuilder<UIModel<Album>>(
        stream: _viewModel.output.album,
        builder: (context, snapshot) {
          final UIModel<Album> uiModel = snapshot.data!;
          switch (uiModel.state) {
            case UIState.ok:
              Album album = uiModel.data!;
              return Text(album.title);
            case UIState.loading:
              return const Center(child: CircularProgressIndicator());
            case UIState.error:
              Object error = uiModel.error!;
              return Center(
                child: Text(error.toString()),
              );
          }
        },
      ),
    );
  }
}
