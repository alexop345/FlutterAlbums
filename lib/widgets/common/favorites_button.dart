import 'package:albums/themes/app_icons.dart';
import 'package:flutter/material.dart';

class FavoritesButton extends StatefulWidget {
  const FavoritesButton({
    super.key,
  });

  @override
  State<FavoritesButton> createState() {
    return _FavoritesButtonState();
  }
}

class _FavoritesButtonState extends State<FavoritesButton> {
  final IconData iconFavorite = AppIcons.favoriteIcon;

  final IconData iconUnfavorite = AppIcons.unfavoriteIcon;

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(
        isFavorite ? iconFavorite : iconUnfavorite,
        color: Theme.of(context).primaryColor,
        key: ValueKey(isFavorite),
      ),
    );
  }
}
