// To parse this JSON data, do
//
//     final albumData = albumDataFromJson(jsonString);

import 'dart:convert';


class AlbumData {
    List<Datum> data;
    Links links;
    Meta meta;

    AlbumData({
        this.data,
        this.links,
        this.meta,
    });

    factory AlbumData.fromJson(Map<String, dynamic> json) => AlbumData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
    };
}

class Datum {
    int id;
    String cover;
    String name;
    DatumArtist artist;
    bool condition;
    List<Song> songs;
    String detail;

    Datum({
        this.id,
        this.cover,
        this.name,
        this.artist,
        this.condition,
        this.songs,
        this.detail,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        artist: DatumArtist.fromJson(json["artist"]),
        condition: json["condition"],
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "artist": artist.toJson(),
        "condition": condition,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
        "detail": detail,
    };
}

class DatumArtist {
    String name;
    String detail;

    DatumArtist({
        this.name,
        this.detail,
    });

    factory DatumArtist.fromJson(Map<String, dynamic> json) => DatumArtist(
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

class Links {
    String first;
    String last;
    dynamic prev;
    String next;

    Links({
        this.first,
        this.last,
        this.prev,
        this.next,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
    };
}

class Meta {
    int currentPage;
    int from;
    int lastPage;
    String path;
    int perPage;
    int to;
    int total;

    Meta({
        this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}
