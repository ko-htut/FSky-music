import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fskymusic/page/login_page.dart';
import 'package:fskymusic/route/route_handles.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";
  static String album = "/album";
  static String allalbumPage = "/allalbumPage";
  static String allsongPgae = "/allsongPgae";
  static String artist = "/artist";
  static String artistlist = "/artistlist";
  static String playSongs = "/play_songs";
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!! $params");
      return LoginPage();
    });
    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
    router.define(album, handler: albumHandler);
    router.define(playSongs, handler: playSongsHandler);
    router.define(allalbumPage, handler: goAllAlbumPageHandler);
    router.define(allsongPgae, handler: goAllSongPageHandler);
    router.define(artist, handler: artistHandler);
    router.define(artistlist, handler: artistlistHandler);
  }
}
