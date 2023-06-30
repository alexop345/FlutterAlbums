import 'package:albums/repo/albums_repo.dart';
import 'package:albums/repo/shared_pref_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumsRepo extends Mock implements AlbumsRepo {}

class MockSharedPrefRepo extends Mock implements SharedPrefRepo {}
