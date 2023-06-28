import 'package:albums/models/album.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'albums_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class AlbumsService {
  factory AlbumsService(Dio dio) = _AlbumsService;

  @GET('albums')
  Future<List<Album>> getAlbums();
}
