import 'package:albums/models/album.dart';
import 'package:albums/networking/enpoint_structure.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'albums_service.g.dart';

@RestApi(baseUrl: '$urlProtocol$urlDomain/')
abstract class AlbumsService {
  factory AlbumsService(Dio dio, {required String baseUrl}) = _AlbumsService;

  @GET('albums')
  Future<List<Album>> getAlbums();
}
