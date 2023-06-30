class LastUpdateDuration {
  final Duration duration;

  LastUpdateDuration(this.duration);

  int get days => duration.inDays;
  int get hours => days == 0 ? duration.inHours : duration.inHours % days;
  int get minutes => hours == 0 ? duration.inMinutes : duration.inMinutes % hours;
}
