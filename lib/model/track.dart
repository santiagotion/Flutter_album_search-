class Track {
  final int? duration;
  final String? trackName;
  final int? rank;

  Track({this.duration, this.trackName, this.rank});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      duration: json['duration'] as int?,
      trackName: json['name'] as String?,
      rank: json['@attr']['rank'] as int?,
    );
  }
}
