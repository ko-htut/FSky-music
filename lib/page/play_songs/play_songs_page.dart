import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/page/play_songs/widget_song_progress.dart';
import 'package:fskymusic/provider/play_songs_model.dart';
import 'package:fskymusic/utils/utils.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_img_menu.dart';
import 'package:fskymusic/widget/widget_play_bottom_menu.dart';
import 'package:fskymusic/widget/widget_round_img.dart';
import 'package:provider/provider.dart';

import '../../application.dart';

class PlaySongsPage extends StatefulWidget {
  @override
  _PlaySongsPageState createState() => _PlaySongsPageState();
}

class _PlaySongsPageState extends State<PlaySongsPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _stylusController;
  Animation<double> _stylusAnimation;
  int switchIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _stylusController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _stylusAnimation =
        Tween<double>(begin: -0.03, end: -0.10).animate(_stylusController);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(builder: (context, model, child) {
      var curSong = model.curSong;
      if (model.curState == AudioPlayerState.PLAYING) {
        _controller.forward();
        _stylusController.reverse();
      } else {
        _controller.stop();
        _stylusController.forward();
      }
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Utils.showNetImage(
              '${curSong.picUrl}',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 100,
                sigmaX: 100,
              ),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            AppBar(
              centerTitle: true,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    model.curSong.name,
                    style: commonWhiteTextStyle,
                  ),
                  Text(
                    model.curSong.artists,
                    style: smallWhite70TextStyle,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: kToolbarHeight + Application.statusBarHeight),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          if (switchIndex == 0) {
                            switchIndex = 1;
                          } else {
                            switchIndex = 0;
                          }
                        });
                      },
                      child: IndexedStack(
                        index: switchIndex,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(150)),
                                  child: RotationTransition(
                                    turns: _controller,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        prefix0.Image.asset(
                                          'images/bet.png',
                                          width: ScreenUtil().setWidth(550),
                                        ),
                                        RoundImgWidget(
                                            '${curSong.picUrl}', 370),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                child: RotationTransition(
                                  turns: _stylusAnimation,
                                  alignment: Alignment(
                                      -1 +
                                          (ScreenUtil().setWidth(45 * 2) /
                                              (ScreenUtil().setWidth(293))),
                                      -1 +
                                          (ScreenUtil().setWidth(45 * 2) /
                                              (ScreenUtil().setWidth(504)))),
                                  child: Image.asset(
                                    'images/bgm.png',
                                    width: ScreenUtil().setWidth(205),
                                    height: ScreenUtil().setWidth(352.8),
                                  ),
                                ),
                                alignment: Alignment(0.25, -1),
                              ),
                            ],
                          ),
                          Center(
                              child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("I need your love "
                                        "I need your time"
                                        "When everything's wrong"
                                        "You make it right"
                                        "I feel so high"
                                        "I come alive"
                                        "I need to be free with you tonight"
                                        "I need your love"
                                        "I need your love"
                                        "I take a deep breath every time I pass your door"
                                        "I know you're there but I can't see you anymore"
                                        "And that's the reason you're in the dark"
                                        "I've been a stranger ever since we fell apart"
                                        "I feel so out of sea"
                                        "Watch my eyes are filled with fear"
                                        "Tell me do you feel the same"
                                        "Hold me in your arms again"
                                        "I need your love"
                                        "I need your time"
                                        "When everything's wrong"
                                        "You make it right"
                                        "I feel so high"
                                        "I go alive"
                                        "I need to be free with you tonight"
                                        "I need your love"
                                        "I need your love"
                                        "Now I'm dreaming, will ever find you now?"
                                        "I walk in circles but I never make it out"
                                        "What I mean to you, do I belong"
                                        "I try to fight this but…"),
                                  )))
                        ],
                      ),
                    ),
                  ),
                  buildSongsHandle(model),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    child: SongProgressWidget(model),
                  ),
                  PlayBottomMenuWidget(model),
                  VEmptyView(20),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget buildSongsHandle(PlaySongsModel model) {
    return Container(
      height: ScreenUtil().setWidth(100),
      child: Row(
        children: <Widget>[
          ImageMenuWidget('images/icon_dislike.png', 80),
          ImageMenuWidget(
            'images/icon_song_download.png',
            80,
            onTap: () {},
          ),
          ImageMenuWidget(
            'images/bfc.png',
            80,
            onTap: () {},
          ),
          ImageMenuWidget('images/icon_song_more.png', 80),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _stylusController.dispose();
    super.dispose();
  }
}
