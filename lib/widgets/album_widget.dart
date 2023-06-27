import 'package:albums/models/album.dart';
import 'package:flutter/material.dart';

class AlbumWidget extends StatelessWidget {
  final Album album;

  const AlbumWidget(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(album.title),
        Text('Album with id: ${album.id}'),
      ],
    );
  }
}
