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
  bool isInit = true;
  bool isLoading = false;

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
      isInit = false;
    });
  }

  void getTrackListByGenre(String genre) async {
    var data = await TracksService().getTrackListByGenre(genre);

    Tracks tracks = new Tracks.fromJson(data);

    setState(() {
      trackList = tracks.tracks;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isInit
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            getTrackListByGenre('pop');
                          });
                        },
                        child: Text('Pop'),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            getTrackListByGenre('rock');
                          });
                        },
                        child: Text('Rock'),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            getTrackListByGenre('hip hop');
                          });
                        },
                        child: Text('Hip Hop'),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            getTrackListByGenre('country');
                          });
                        },
                        child: Text('Country'),
                      ),
                      Visibility(
                          visible: isLoading,
                          child: CircularProgressIndicator()),
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
                              backgroundImage:
                                  NetworkImage(trackList[index].images),
                              backgroundColor: Colors.transparent,
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
      ),
    );
  }
}
