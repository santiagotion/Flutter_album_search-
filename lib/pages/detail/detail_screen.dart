import 'package:album_search/apis/response.dart';
import 'package:album_search/model/album_detail.dart';
import 'package:album_search/model/album_search_preview.dart';
import 'package:album_search/pages/detail/controller/album_detail_view_model.dart';
import 'package:album_search/pages/detail/widgets/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final AlbumPreview data;
  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _DetailsScreenState createState() => _DetailsScreenState(data: data);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final AlbumPreview data;

  late Future<AlbumDetails> futureAlbum;

  _DetailsScreenState({required this.data});
  @override
  Widget build(BuildContext context) {
    Widget detailWidget(BuildContext context, ApiResponse apiResponse) {
      AlbumDetails? albumInfo = apiResponse.data;
      switch (apiResponse.status) {
        case Status.loading:
          return const Center(child: CircularProgressIndicator());
        case Status.completed:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 8,
                child: DetailWidget(albumInfo!, (album) {
                  Provider.of<AlbumDetailViewModel>(context, listen: false);
                }),
              ),
            ],
          );
        case Status.error:
          return Center(
            child: Text('${apiResponse.message}'),
          );
        case Status.initial:
          return const Center(child: CircularProgressIndicator());
        default:
          return const Center(
            child: Text('...'),
          );
      }
    }

    ApiResponse apiResponse =
        Provider.of<AlbumDetailViewModel>(context).response;
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
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          height: 40,
                          child: Icon(
                            Icons.chevron_left_sharp,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 90,
                            width: 90,
                            color: Colors.white,
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(data.imageUrl![2].url ?? ''),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    data.albumName.toString(),
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        data.artistName.toString(),
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                bottom: false,
              ),
            ),
            Expanded(child: detailWidget(context, apiResponse)),
          ]),
    );
  }
}
