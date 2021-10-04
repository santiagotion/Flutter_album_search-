import 'package:album_search/apis/response.dart';
import 'package:album_search/model/album_detail.dart';
import 'package:album_search/model/album_search_preview.dart';
import 'package:album_search/repository/album_detail_repository.dart';
import 'package:flutter/cupertino.dart';

class AlbumDetailViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  AlbumPreview? _preview;

  ApiResponse get response {
    return _apiResponse;
  }

  AlbumPreview? get album {
    return _preview;
  }

  Future<void> fetchMediaData(String artist, String album) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      AlbumDetails mediaList =
          await AlbumRepository().fetchResuhlt(artist, album);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      // ignore: avoid_print
      print(e);
    }
    notifyListeners();
  }
}
