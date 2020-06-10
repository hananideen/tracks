class Tracks {
  final List<Track> tracks;

  Tracks({this.tracks});

  factory Tracks.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['tracks'] as List;
    List<Track> trackList = list.map((i) => Track.fromJson(i)).toList();

    return new Tracks(tracks: trackList);
  }
}

class Track {
  int id;
  String title;
  String artist;
  String images;
  List<String> genres;
  String runtime;

  Track(
      {this.id,
      this.title,
      this.artist,
      this.images,
      this.genres,
      this.runtime});

  factory Track.fromJson(Map<String, dynamic> json) {
    var genresFromJson = json['genres'];
    List<String> genreList = new List<String>.from(genresFromJson);

    var runtimeFromJson = json['runtime'];
    var minutes = ((runtimeFromJson % 3600) / 60).toInt();
    var seconds = runtimeFromJson % 60;
    String runtime = '$minutes:$seconds';

    return Track(
      id: json['id'],
      title: json['title'],
      artist: json['track_artists'][0]['artist']['name'],
      images: json['images']['poster']['url'],
      genres: genreList,
      runtime: runtime,
    );
  }
}
