import 'package:flutter/material.dart';
import 'package:tracks/model/track.dart';
import 'package:tracks/services/tracks_service.dart';
import 'dart:ui';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.id});

  final id;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Track track;
  bool isLoading = true;

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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(track.images), fit: BoxFit.cover)),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: NetworkImage(track.images),
                              height: 300,
                              width: 300,
                            ),
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
                  ),
                ),
              ),
      ),
    );
  }
}
