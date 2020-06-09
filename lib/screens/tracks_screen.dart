import 'package:flutter/material.dart';
import 'package:tracks/model/track.dart';
import 'package:tracks/screens/detail_screen.dart';
import 'package:tracks/services/tracks_service.dart';

class TracksScreen extends StatefulWidget {
  @override
  _TracksScreenState createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  List<Track> trackList;

  @override
  void initState() {
    super.initState();
    getTrackListData();
  }

  void getTrackListData() async {
    var data = await TracksService().getTrackList();

    Tracks tracks = new Tracks.fromJson(data);

    setState(() {
      trackList = tracks.tracks;
    });
  }

  void getTrackListByGenre(String genre) async {
    var data = await TracksService().getTrackListByGenre(genre);

    Tracks tracks = new Tracks.fromJson(data);

    setState(() {
      trackList = tracks.tracks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  getTrackListByGenre('pop');
                },
                child: Text('Pop'),
              ),
              FlatButton(
                onPressed: () {
                  getTrackListByGenre('rock');
                },
                child: Text('Rock'),
              ),
              FlatButton(
                onPressed: () {
                  getTrackListByGenre('hip hop');
                },
                child: Text('Hip Hop'),
              ),
              FlatButton(
                onPressed: () {
                  getTrackListByGenre('country');
                },
                child: Text('Country'),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                itemCount: trackList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(trackList[index].title),
                    subtitle: Text(trackList[index].artist),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(trackList[index].images),
                    ),
                    trailing: Text(trackList[index].runtime.toString()),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(id: trackList[index].id),
                          ));
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
