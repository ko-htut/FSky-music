class Song {
  int id; // 歌曲id
  String name; // 歌曲名称
  String artists; // 演唱者
  String picUrl; // 歌曲图片
  String songUrl; // 歌曲图片

  Song(this.id, {this.name, this.artists, this.picUrl, this.songUrl});

  Song.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        artists = json['artists'],
        picUrl = json['picUrl'],
        songUrl = json['songUrl'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'artists': artists,
        'picUrl': picUrl,
        'songUrl': songUrl,
      };

  @override
  String toString() {
    return 'Song{id: $id, name: $name, artists: $artists}';
  }
}
