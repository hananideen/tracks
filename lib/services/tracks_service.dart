import 'package:tracks/services/networking.dart';

const apiURL = 'https://api.popsical.tv/v3/songs';

class TracksService {
  Future<dynamic> getTrackList() async {
    NetworkHelper networkHelper = NetworkHelper('$apiURL.json');

    var tracksData = await networkHelper.getData();
    return tracksData;
  }

  Future<dynamic> getTrack(int id) async {
    NetworkHelper networkHelper = NetworkHelper('$apiURL/$id.json');

    var trackData = await networkHelper.getData();
    return trackData;
  }
}
