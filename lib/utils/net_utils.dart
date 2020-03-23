import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fskymusic/model/album.dart';
import 'package:fskymusic/model/artist.dart' as aa;
import 'package:fskymusic/model/albumsong.dart';
import 'package:fskymusic/model/artistdata.dart';
import 'package:fskymusic/model/song.dart';
import 'package:fskymusic/model/user.dart';
import 'package:fskymusic/model/banner.dart' as ba;
import 'package:fskymusic/route/navigate_service.dart';
import 'package:fskymusic/route/routes.dart';
import 'package:fskymusic/utils/utils.dart';
import 'package:fskymusic/widget/loading.dart';

import '../application.dart';

class NetUtils {
  static Dio _dio = Dio();
  static final String baseUrl = 'http://dashboard.fskymusic.com/api/';
  static Future<Response> _get(
    BuildContext context,
    String url, {
    Map<String, dynamic> params,
    dynamic data,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading) Loading.showLoading(context);
    try {
      if (url == "login") {
        return await _dio.post("$baseUrl$url", data: data);
      }
      return await _dio.get(
        "$baseUrl$url",
      );
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
          _reLogin();
          return Future.error(Response(data: -1));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static void _reLogin() {
    Future.delayed(Duration(milliseconds: 200), () {
      Application.getIt<NavigateService>().popAndPushNamed(Routes.login);
      Utils.showToast('Login ဝင်၇ောက်မှု မအောင်မြင်ပါ');
    });
  }

  static Future<User> login(
      BuildContext context, String email, String password) async {
    print("$email $password");
    var response = await _get(context, 'login', data: {
      'email': email,
      'password': password,
    });
    print(response.data);
    return User.fromJson(response.data);
  }

  static Future<AlbumData> getAlbumData(BuildContext context,
      {String ss}) async {
    var response = await _get(
      context,
      'album',
    );
    return AlbumData.fromJson(response.data);
  }

  static Future<aa.ArtistData> getartist(
    BuildContext context,
  ) async {
    var response = await _get(
      context,
      'artist',
    );
    return aa.ArtistData.fromJson(response.data);
  }

  static Future<SongData> getSongData(
    BuildContext context,
  ) async {
    var response = await _get(
      context,
      'song?page=1',
    );
    return SongData.fromJson(response.data);
  }

  static Future<ba.Banner> getBannerData() async {
    // var response = await _get(
    //   context,
    //   'banner',
    // );
    var response =
        await _dio.get("http://dashboard.fskymusic.com/public/api/banner");
    return ba.Banner.fromJson(response.data);
  }

  static Future<AlbumSong> getAlbumSongData(BuildContext context,
      {String i}) async {
    var response = await _get(
      context,
      "album$i",
    );
    return AlbumSong.fromJson(response.data);
  }
}
