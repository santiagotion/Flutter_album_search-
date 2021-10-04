import 'package:album_search/model/track.dart';

class AlbumDetails {
  final String? playCount;
  final String? published;
  final String? content;
  final String? summary;
  final List<dynamic>? tracks;

  AlbumDetails(
      {this.playCount,
      this.published,
      this.content,
      this.summary,
      this.tracks});

  factory AlbumDetails.fromJson(Map<String, dynamic> json) {
    final jsonData = json['tracks']['track'];

    List<dynamic> trackList =
        jsonData.map((tagJson) => Track.fromJson(tagJson)).toList();

    return AlbumDetails(
      playCount: json['playcount'],
      published: json['wiki']['published'],
      content: json['wiki']['content'],
      summary: json['wiki']['summary'],
      tracks: trackList,
    );
  }
}
