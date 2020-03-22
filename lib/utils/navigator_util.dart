import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fskymusic/model/album.dart' as ab;
import 'package:fskymusic/model/artist.dart';
import 'package:fskymusic/route/routes.dart';
import 'package:fskymusic/utils/fluro_convert_utils.dart';

import '../application.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.material);
  }

  static void goLoginPage(BuildContext context) {
    _navigateTo(context, Routes.login, clearStack: true);
  }

  static void goAllAlbumPage(BuildContext context) {
    _navigateTo(context, Routes.allalbumPage);
  }

  static void goAllSongPageHandler(BuildContext context) {
    _navigateTo(context, Routes.allsongPgae);
  }

  static void goArtistHandler(BuildContext context,
      {@required Datum data}) {
    _navigateTo(context,
        "${Routes.artist}?data=${FluroConvertUtils.object2string(data)}");
  }

  static void goArtistlistHandler(BuildContext context) {
    _navigateTo(context, Routes.artistlist);
  }

  static void goHomePage(BuildContext context) {
    _navigateTo(context, Routes.home, clearStack: true);
  }

  static void goAlbumPage(BuildContext context, {@required ab.Datum data}) {
    _navigateTo(context,
        "${Routes.album}?data=${FluroConvertUtils.object2string(data)}");
  }

  static void goPlaySongsPage(BuildContext context) {
    _navigateTo(context, Routes.playSongs, clearStack: false);
  }
}
