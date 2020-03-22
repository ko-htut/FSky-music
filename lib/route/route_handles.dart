import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fskymusic/model/album.dart' as ab;
import 'package:fskymusic/model/artist.dart' as at;
import 'package:fskymusic/page/album/album_page.dart';
import 'package:fskymusic/page/album/all_album_page.dart';
import 'package:fskymusic/page/artic/artic_list_page.dart';
import 'package:fskymusic/page/artic/artist_page.dart';
import 'package:fskymusic/page/home/home_page.dart';
import 'package:fskymusic/page/login_page.dart';
import 'package:fskymusic/page/play_songs/play_songs_page.dart';
import 'package:fskymusic/page/song/song_list_page.dart';
import 'package:fskymusic/page/splash_page.dart';
import 'package:fskymusic/utils/fluro_convert_utils.dart';


var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SplashPage();
});

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return LoginPage();
});
var goAllAlbumPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return AllAlbumPage();
});
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return HomePage();
});
var artistHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  String data1 = params['data'].first;
  return ArtistPage(
      data: at.Datum.fromJson(FluroConvertUtils.string2map(data1)));
});
var artistlistHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return ArtistListPage();
});
var goAllSongPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SongPlayListPage();
});
var albumHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  String data = params['data'].first;
  return AlbumPage(ab.Datum.fromJson(FluroConvertUtils.string2map(data)));
});
// ArtistData
var playSongsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return PlaySongsPage();
});
