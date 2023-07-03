import 'package:albums/models/album.dart';

class AlbumListData {
  final List<Album> albums;
  final LastUpdate? lastUpdate;
  final bool isRecent;

  AlbumListData.fromDate({required this.albums, required DateTime date})
      : lastUpdate = LastUpdate.fromDate(date),
        isRecent = false;

  AlbumListData.recent({required this.albums})
      : lastUpdate = null,
        isRecent = true;
}

class LastUpdate {
  late int time;
  late String period;

  LastUpdate.fromDate(DateTime date) {
    Duration duration = DateTime.now().difference(date);
    if (duration.inMinutes < 60) {
      time = duration.inMinutes;
      period = 'm';
    } else if (duration.inHours < 24) {
      time = duration.inHours;
      period = 'h';
    } else {
      time = duration.inDays;
      period = 'd';
    }
  }
}
