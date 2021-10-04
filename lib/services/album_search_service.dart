import 'dart:convert';
import 'dart:io';
import 'package:album_search/apis/exception.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class AlbumSearchService {
  Future getResponse(String album) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(
          "https://ws.audioscrobbler.com/2.0/?method=album.search&album=" +
              album +
              "&api_key=" +
              "YOUR_API_KEY_HERE" "&format=json"));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
