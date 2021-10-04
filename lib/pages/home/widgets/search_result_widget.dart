import 'package:album_search/model/album_search_preview.dart';
import 'package:album_search/pages/detail/detail_screen.dart';
import 'package:album_search/pages/detail/controller/album_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSearchWidget extends StatefulWidget {
  final List<AlbumPreview> _previewList;
  final Function _function;

  const ListSearchWidget(this._previewList, this._function, {Key? key})
      : super(key: key);

  @override
  _ListSearchWidgetState createState() => _ListSearchWidgetState();
}

class _ListSearchWidgetState extends State<ListSearchWidget> {
  Widget _buildAlbumResult(AlbumPreview preview) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(preview.imageUrl![2].url ?? ''),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          preview.albumName ?? '',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          preview.artistName ?? '',
                          style: Theme.of(context).primaryTextTheme.bodyText2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                      ]),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_sharp),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget._previewList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            AlbumPreview data = widget._previewList[index];
            return GestureDetector(
                onTap: () {
                  if (null != data.artistName) {
                    widget._function(data);

                    Navigator.push(
                      (context),
                      MaterialPageRoute(
                        builder: ((context) => DetailsScreen(data: data)),
                      ),
                    );
                  }
                  Provider.of<AlbumDetailViewModel>(context, listen: false)
                      .fetchMediaData(data.artistName.toString(),
                          data.albumName.toString());
                },
                child: Container(
                  color: Colors.white,
                  child: _buildAlbumResult(data),
                ));
          },
        ),
      ]),
    );
  }
}
