import 'package:albums/models/album.dart';
import 'package:albums/screens/album_details/album_details_screen.dart';
import 'package:albums/themes/app_diments.dart';
import 'package:albums/themes/app_font_style.dart';
import 'package:albums/widgets/common/favorites_button.dart';
import 'package:flutter/material.dart';

class AlbumListItemWidget extends StatelessWidget {
  final Album album;

  const AlbumListItemWidget(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: AppDimens.containerDefaultSpacingAll,
        decoration: BoxDecoration(
          border: Border.all(width: 0.1),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.article,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: Padding(
                padding: AppDimens.leftNormalSpacing,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      album.title,
                      style: AppFontStyle.titleText,
                    ),
                    Text('Album with id: ${album.id}'),
                  ],
                ),
              ),
            ),
            const FavoritesButton(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => AlbumDetailsScreen(album),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
