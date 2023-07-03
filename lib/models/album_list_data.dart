import 'package:albums/models/album.dart';

class AlbumListData {
  final List<Album> albums;
  final LastUpdate? lastUpdate;
  final bool isRecent;

  AlbumListData.fromDate({required this.albums, required DateTime date, DateTime? now})
      : lastUpdate = LastUpdate.fromDate(date, now ?? DateTime.now()),
        isRecent = false;

  AlbumListData.recent({required this.albums})
      : lastUpdate = null,
        isRecent = true;

  @override
  int get hashCode => isRecent.hashCode ^ lastUpdate.hashCode ^ albums.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumListData &&
          isRecent == other.isRecent &&
          lastUpdate == other.lastUpdate &&
          albums == other.albums;
}

class LastUpdate {
  late int time;
  late String period;

  LastUpdate.fromDate(DateTime old, DateTime now) {
    Duration duration = now.difference(old);
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

  @override
  int get hashCode => time.hashCode ^ period.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastUpdate &&
          time == other.time &&
          period == other.period;
  
}
