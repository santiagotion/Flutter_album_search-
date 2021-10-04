import 'package:album_search/model/image.dart';

class AlbumPreview {
  final String? albumUrl;
  final String? albumName;
  final String? artistName;
  final List<Image>? imageUrl;

  AlbumPreview({this.albumUrl, this.albumName, this.artistName, this.imageUrl});

  factory AlbumPreview.fromJson(Map<String, dynamic> json) {
    final jsonData = json['image'] as List;
    List<Image> imageList =
        jsonData.map((tagJson) => Image.fromJson(tagJson)).toList();
    return AlbumPreview(
      albumUrl: json['url'] as String?,
      albumName: json['name'] as String?,
      artistName: json['artist'] as String?,
      imageUrl: imageList,
    );
  }
}
