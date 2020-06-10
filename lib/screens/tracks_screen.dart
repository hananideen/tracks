import 'package:flutter/material.dart';
import 'package:tracks/components/filter_button.dart';
import 'package:tracks/model/track.dart';
import 'package:tracks/screens/detail_screen.dart';
import 'package:tracks/services/tracks_service.dart';

enum Genre { pop, rock, hiphop, country, all }

extension GenreExtension on Genre {
  String get genre {
    switch (this) {
      case Genre.pop:
        return 'pop';
      case Genre.rock:
        return 'rock';
      case Genre.hiphop:
        return 'hip hop';
      case Genre.country:
        return 'country';
      default:
        return null;
    }
  }
}

const kActiveFilterColour = Colors.pinkAccent;
const kInactiveFilterColour = Color(0xFF1D1E33);

class TracksScreen extends StatefulWidget {
  @override
  _TracksScreenState createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  List<Track> trackList;
  bool isInit = true;
  bool isLoading = false;
  Genre selectedGenre;

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
      isLoading = false;
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

  void onFilter(Genre genre) {
    setState(() {
      isLoading = true;
      if (selectedGenre == genre) {
        selectedGenre = Genre.all;
        getTrackListData();
      } else {
        selectedGenre = genre;
        getTrackListByGenre(genre.genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track List'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 20.0,
              child: Visibility(
                  visible: isLoading, child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
      body: Center(
        child: isInit
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FilterButton(
                            colour: selectedGenre == Genre.pop
                                ? kActiveFilterColour
                                : kInactiveFilterColour,
                            onPress: () {
                              onFilter(Genre.pop);
                            },
                            title: 'Pop',
                          ),
                        ),
                        Expanded(
                          child: FilterButton(
                            colour: selectedGenre == Genre.rock
                                ? kActiveFilterColour
                                : kInactiveFilterColour,
                            onPress: () {
                              onFilter(Genre.rock);
                            },
                            title: 'Rock',
                          ),
                        ),
                        Expanded(
                          child: FilterButton(
                            colour: selectedGenre == Genre.hiphop
                                ? kActiveFilterColour
                                : kInactiveFilterColour,
                            onPress: () {
                              onFilter(Genre.hiphop);
                            },
                            title: 'Hip Hop',
                          ),
                        ),
                        Expanded(
                          child: FilterButton(
                            colour: selectedGenre == Genre.country
                                ? kActiveFilterColour
                                : kInactiveFilterColour,
                            onPress: () {
                              onFilter(Genre.country);
                            },
                            title: 'Country',
                          ),
                        ),
                      ],
                    ),
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
                            trailing: Text(trackList[index].runtime),
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
