import 'package:albums/app.dart';
import 'package:albums/flavor_config.dart';
import 'package:flutter/material.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    values: FlavorValues(baseUrl: 'https://jsonplaceholder.typicode.com/'),
  );
  runApp(
    const App(),
  );
}
