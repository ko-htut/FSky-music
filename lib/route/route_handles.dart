import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fskymusic/model/album.dart';
import 'package:fskymusic/page/album/album_page.dart';
import 'package:fskymusic/page/home/home_page.dart';
import 'package:fskymusic/page/login_page.dart';
import 'package:fskymusic/page/play_songs/play_songs_page.dart';
import 'package:fskymusic/page/splash_page.dart';
import 'package:fskymusic/utils/fluro_convert_utils.dart';

// splash 页面
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SplashPage();
});

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return LoginPage();
});

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return HomePage();
});

var albumHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  String data = params['data'].first;
  return AlbumPage(Datum.fromJson(FluroConvertUtils.string2map(data)));
});

var playSongsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PlaySongsPage();
    });

