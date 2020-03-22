// To parse this JSON data, do
//
//     final artistDData = artistDDataFromJson(jsonString);

import 'dart:convert';

ArtistDData artistDDataFromJson(String str) => ArtistDData.fromJson(json.decode(str));

String artistDDataToJson(ArtistDData data) => json.encode(data.toJson());

class ArtistDData {
    Data data;

    ArtistDData({
        this.data,
    });

    factory ArtistDData.fromJson(Map<String, dynamic> json) => ArtistDData(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String profile;
    String name;
    List<AlbumElement> album;
    List<Song> song;

    Data({
        this.id,
        this.profile,
        this.name,
        this.album,
        this.song,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        profile: json["profile"],
        name: json["name"],
        album: List<AlbumElement>.from(json["album"].map((x) => AlbumElement.fromJson(x))),
        song: List<Song>.from(json["song"].map((x) => Song.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profile": profile,
        "name": name,
        "album": List<dynamic>.from(album.map((x) => x.toJson())),
        "song": List<dynamic>.from(song.map((x) => x.toJson())),
    };
}

class AlbumElement {
    int id;
    String cover;
    String name;
    String about;
    AlbumArtist artist;
    bool condition;
    List<Song> songs;
    String detail;

    AlbumElement({
        this.id,
        this.cover,
        this.name,
        this.about,
        this.artist,
        this.condition,
        this.songs,
        this.detail,
    });

    factory AlbumElement.fromJson(Map<String, dynamic> json) => AlbumElement(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        about: json["about"],
        artist: AlbumArtist.fromJson(json["artist"]),
        condition: json["condition"],
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "about": about,
        "artist": artist.toJson(),
        "condition": condition,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
        "detail": detail,
    };
}

class AlbumArtist {
    String name;
    String detail;

    AlbumArtist({
        this.name,
        this.detail,
    });

    factory AlbumArtist.fromJson(Map<String, dynamic> json) => AlbumArtist(
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
    SongAlbum album;
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
        album: SongAlbum.fromJson(json["album"]),
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

class SongAlbum {
    String albumName;
    String albumDetail;

    SongAlbum({
        this.albumName,
        this.albumDetail,
    });

    factory SongAlbum.fromJson(Map<String, dynamic> json) => SongAlbum(
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
