import 'package:album_search/model/album_detail.dart';
import 'package:album_search/model/track.dart';
import 'package:flutter/material.dart';


class DetailWidget extends StatefulWidget {
  final AlbumDetails _albumDetails;
  final Function _function;

  const DetailWidget(this._albumDetails, this._function, {Key? key})
      : super(key: key);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Published:",
                  style: Theme.of(context).primaryTextTheme.headline3),
              const SizedBox(
                height: 5,
              ),
              Text(widget._albumDetails.published.toString(),
                  style: Theme.of(context).primaryTextTheme.headline4),
              const SizedBox(
                height: 18,
              ),
              Text("Summary:",
                  style: Theme.of(context).primaryTextTheme.headline3),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget._albumDetails.summary.toString(),
                style: Theme.of(context).primaryTextTheme.headline4,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 18,
              ),
              Text("Tracks:",
                  style: Theme.of(context).primaryTextTheme.headline3),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              ListView.separated(
                padding: const EdgeInsets.only(top: 4, bottom: 15),
                shrinkWrap: true,
                itemCount: widget._albumDetails.tracks?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  Track track = widget._albumDetails.tracks?[index];

                  String intToMin(int value) {
                    int h, m, s;
                    h = value ~/ 3600;
                    m = ((value - h * 3600)) ~/ 60;
                    s = value - (h * 3600) - (m * 60);
                    String result = "$m:$s";

                    return result;
                  }

                  var duration = intToMin(track.duration!);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.music_note,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            track.trackName.toString(),
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        ],
                      ),
                      Text(
                        duration,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 30,
                  );
                },
              ),
            ]),
      ),
    );
  }
}
