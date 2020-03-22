class Song {
  int id;
  String name;
  String artists;
  String picUrl;
  String songUrl;
  String songLrc;

  Song(this.id, {this.name, this.artists, this.picUrl, this.songUrl,this.songLrc});

  Song.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        artists = json['artists'],
        picUrl = json['picUrl'],
        songUrl = json['songUrl'],
        songLrc = json['songLrc'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'artists': artists,
        'picUrl': picUrl,
        'songUrl': songUrl,
        'songLrc': songLrc,
      };

  @override
  String toString() {
    return 'Song{id: $id, name: $name, artists: $artists}';
  }
}
