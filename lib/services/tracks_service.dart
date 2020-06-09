import 'package:tracks/services/networking.dart';

const apiURL = 'https://api.popsical.tv/v3/songs.json';

class TracksModel {
  Future<dynamic> getTrackList() async {
    NetworkHelper networkHelper = NetworkHelper(apiURL);

    var tracksData = await networkHelper.getData();
    return tracksData;
  }
}
