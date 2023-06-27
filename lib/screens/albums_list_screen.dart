import 'package:albums/models/album.dart';
import 'package:albums/networking/albums_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AlbumsListScreen extends StatelessWidget {
  const AlbumsListScreen({super.key});

  FutureBuilder _body() {
    final albumsService =
        AlbumsService(Dio(BaseOptions(contentType: "application/json")));
    
    return FutureBuilder(
      future: albumsService.getAlbums(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Album> albums = snapshot.data;
          return _album(albums);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _album(List<Album> albums) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(albums[index].title),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: _body(),
    );
  }
}
