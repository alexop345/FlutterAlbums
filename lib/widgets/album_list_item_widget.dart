import 'package:albums/models/album.dart';
import 'package:albums/themes/app_colors.dart';
import 'package:albums/themes/app_font_style.dart';
import 'package:flutter/material.dart';

class AlbumListItemWidget extends StatelessWidget {
  final Album album;

  const AlbumListItemWidget(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 0.1),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.backgroundColor,
              child: Icon(
                Icons.article,
                color: AppColors.primaryColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
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
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
