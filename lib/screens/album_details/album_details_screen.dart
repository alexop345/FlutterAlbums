import 'package:albums/models/album.dart';
import 'package:albums/themes/app_icons.dart';
import 'package:albums/widgets/common/toggle_icon_button.dart';
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
          ToggleIconButton(
            toggleIcon: AppIcons.favoriteIcon,
            untoggleIcon: AppIcons.notFavoriteIcon,
          ),
        ],
      ),
    );
  }
}
