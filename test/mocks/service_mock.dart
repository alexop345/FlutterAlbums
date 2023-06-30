import 'package:albums/networking/albums_service.dart';
import 'package:albums/networking/network_connection.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumsService extends Mock implements AlbumsService {}

class MockNetworkConnection extends Mock implements NetworkConnection {}
