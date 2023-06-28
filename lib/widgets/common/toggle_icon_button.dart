import 'package:flutter/material.dart';
import 'package:albums/themes/app_colors.dart';

class ToggleIconButton extends StatelessWidget {
  final IconData toggleIcon;
  final IconData untoggleIcon;
  final Color colorIcon;

  const ToggleIconButton({
    super.key,
    required this.toggleIcon,
    required this.untoggleIcon,
    colorIcon,
  }): colorIcon = colorIcon ?? AppColors.primaryColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        untoggleIcon,
        color: colorIcon,
        key: ValueKey(''),
      ),
    );
  }
}
