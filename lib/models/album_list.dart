import 'package:albums/models/album.dart';

class AlbumList {
  final LastUpdate lastUpdate;
  final List<Album> albums;

  AlbumList({required this.albums, lastUpdate}): lastUpdate = lastUpdate ?? LastUpdate.empty();

  AlbumList.fromDate({required this.albums, required DateTime date}): lastUpdate = LastUpdate.fromDate(date);
}

class LastUpdate {
  late int time;
  late String period;

  LastUpdate({required this.time, required this.period});

  LastUpdate.empty(): time = 0, period = '';

  LastUpdate.fromDate(DateTime date){
    Duration duration = DateTime.now().difference(date);
    if (duration.inMinutes < 60) {
      time = duration.inMinutes;
      period = 'm';
    } else  if (duration.inHours < 24) {
      time = duration.inHours;
      period = 'h';
    } else {
      time = duration.inDays;
      period = 'd';
    }
  }
}