import 'package:album_search/model/album_detail.dart';
import 'package:album_search/services/album_detail_service.dart';

class AlbumRepository {
  final _albumService = AlbumService();

  Future<AlbumDetails> fetchResuhlt(String artist, String album) async {
    final response = await _albumService.getResponse(artist, album);
    final jsonData = response['album'];
    dynamic albumDetail = AlbumDetails.fromJson(jsonData);
    return albumDetail;
  }
}
