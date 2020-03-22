
class AlbumSong {
    Data data;

    AlbumSong({
        this.data,
    });
    factory AlbumSong.fromJson(Map<String, dynamic> json) => AlbumSong(
        data: Data.fromJson(json["data"]),
    );
    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String cover;
    String name;
    String about;
    DataArtist artist;
    bool condition;
    List<Song> songs;

    Data({
        this.id,
        this.cover,
        this.name,
        this.about,
        this.artist,
        this.condition,
        this.songs,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        about: json["about"],
        artist: DataArtist.fromJson(json["artist"]),
        condition: json["condition"],
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "about": about,
        "artist": artist.toJson(),
        "condition": condition,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
    };
}

class DataArtist {
    String name;
    String detail;

    DataArtist({
        this.name,
        this.detail,
    });

    factory DataArtist.fromJson(Map<String, dynamic> json) => DataArtist(
        name: json["name"],
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "detail": detail,
    };
}

class Song {
    int id;
    String cover;
    String name;
    SongArtist artist;
    Category category;
    Album album;
    String lyric;
    String source;
    String detail;

    Song({
        this.id,
        this.cover,
        this.name,
        this.artist,
        this.category,
        this.album,
        this.lyric,
        this.source,
        this.detail,
    });

    factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        artist: SongArtist.fromJson(json["artist"]),
        category: Category.fromJson(json["category"]),
        album: Album.fromJson(json["album"]),
        lyric: json["lyric"],
        source: json["source"],
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "artist": artist.toJson(),
        "category": category.toJson(),
        "album": album.toJson(),
        "lyric": lyric,
        "source": source,
        "detail": detail,
    };
}

class Album {
    String albumName;
    String albumDetail;

    Album({
        this.albumName,
        this.albumDetail,
    });

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumName: json["album_name"],
        albumDetail: json["album_detail"],
    );

    Map<String, dynamic> toJson() => {
        "album_name": albumName,
        "album_detail": albumDetail,
    };
}

class SongArtist {
    String artistName;
    String artistDetail;

    SongArtist({
        this.artistName,
        this.artistDetail,
    });

    factory SongArtist.fromJson(Map<String, dynamic> json) => SongArtist(
        artistName: json["artist_name"],
        artistDetail: json["artist_detail"],
    );

    Map<String, dynamic> toJson() => {
        "artist_name": artistName,
        "artist_detail": artistDetail,
    };
}

class Category {
    String categoryName;
    String categoryDetail;

    Category({
        this.categoryName,
        this.categoryDetail,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["category_name"],
        categoryDetail: json["category_detail"],
    );

    Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "category_detail": categoryDetail,
    };
}
