import 'package:albums/models/album.dart';
import 'package:albums/widgets/common/favorites_button.dart';
import 'package:flutter/material.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailsScreen(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
        actions: const [
          FavoritesButton(),
        ],
      ),
    );
  }
}
