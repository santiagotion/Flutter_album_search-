class Image {
  final String? url;
  final String? size;

  Image({this.url, this.size});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['#text'] as String?,
      size: json['size'] as String?,
    );
  }
}
