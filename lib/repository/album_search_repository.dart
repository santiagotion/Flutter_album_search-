import 'package:album_search/model/album_search_preview.dart';
import 'package:album_search/services/album_search_service.dart';

class PreviewRepository {
  final _searchService = AlbumSearchService();

  Future<List<AlbumPreview>> fetchResultList(String value) async {
    dynamic response = await _searchService.getResponse(value);

    final jsonData = response['results']['albummatches']['album'] as List;

    List<AlbumPreview> albumList =
        jsonData.map((tagJson) => AlbumPreview.fromJson(tagJson)).toList();
    return albumList;
  }
}
