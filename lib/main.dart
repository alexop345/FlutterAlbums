import 'package:albums/screens/album_list/album_list_screen.dart';
import 'package:albums/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
      home: const AlbumListScreen(),
    );
  }
}
