class ArtistData {
    List<Datum> data;

    ArtistData({
        this.data,
    });

    factory ArtistData.fromJson(Map<String, dynamic> json) => ArtistData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String profile;
    String name;
    String detail;

    Datum({
        this.id,
        this.profile,
        this.name,
        this.detail,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        profile: json["profile"],
        name: json["name"],
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profile": profile,
        "name": name,
        "detail": detail,
    };
}
