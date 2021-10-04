import 'package:album_search/apis/response.dart';
import 'package:album_search/model/album_search_preview.dart';
import 'package:album_search/pages/home/widgets/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'controller/search_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List<AlbumPreview>? resultList = apiResponse.data as List<AlbumPreview>?;
    switch (apiResponse.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: ListSearchWidget(resultList!, (AlbumPreview media) {
                Provider.of<SearchViewModel>(context, listen: false);
              }),
            ),
          ],
        );
      case Status.error:
        return Center(
          child: Text('${apiResponse.message}'),
        );
      case Status.initial:
      default:
        return const Center(
          child: Text('Search the Album by Name or by Artist'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<SearchViewModel>(context).response;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Find your \nFavourit album',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: TextField(
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                                controller: _inputController,
                                onChanged: (value) {},
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    Provider.of<SearchViewModel>(context,
                                        listen: false);
                                    Provider.of<SearchViewModel>(context,
                                            listen: false)
                                        .fetchMediaData(value);
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Album Name',
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottom: false,
            ),
          ),
          Expanded(child: getMediaWidget(context, apiResponse)),
        ],
      ),
    );
  }
}
