import 'package:albums/models/album.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'albums_service.g.dart';

@RestApi(baseUrl: '${AlbumsService.urlProtocol}${AlbumsService.urlDomain}')
abstract class AlbumsService {
  static const String urlProtocol = 'https://';
  static const String urlDomain = 'jsonplaceholder.typicode.com';
  factory AlbumsService(Dio dio) = _AlbumsService;

  @GET('/albums')
  Future<List<Album>> getAlbums();
}
