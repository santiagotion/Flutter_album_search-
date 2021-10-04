import 'package:album_search/apis/response.dart';
import 'package:album_search/model/album_search_preview.dart';
import 'package:album_search/repository/album_search_repository.dart';
import 'package:flutter/cupertino.dart';

class SearchViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  AlbumPreview? _preview;

  ApiResponse get response {
    return _apiResponse;
  }

  AlbumPreview? get album {
    return _preview;
  }

  Future<void> fetchMediaData(String value) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      List<AlbumPreview> mediaList =
          await SearchRepository().fetchResultList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      // ignore: avoid_print
      print(e);
    }
    notifyListeners();
  }
}
