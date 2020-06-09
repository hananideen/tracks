import 'package:flutter/material.dart';
import 'package:tracks/model/track.dart';
import 'package:tracks/services/tracks_service.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.id});

  final id;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Track track;

  @override
  void initState() {
    super.initState();
    getTrackData();
  }

  void getTrackData() async {
    var data = await TracksService().getTrack(widget.id);

    Track trackData = new Track.fromJson(data);

    setState(() {
      track = trackData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: NetworkImage(track.images),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Text(track.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(track.artist,
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(track.genres.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
