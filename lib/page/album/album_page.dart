import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/model/album.dart';
import 'package:fskymusic/page/album/play_list_desc_dialog.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/h_empty_view.dart';
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_play_list_app_bar.dart';
import 'package:fskymusic/widget/widget_play_list_cover.dart';
import 'package:fskymusic/widget/widget_round_img.dart';

import '../../application.dart';

class AlbumPage extends StatefulWidget {
  final Datum data;

  AlbumPage(this.data);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  double _expandedHeight = ScreenUtil().setWidth(500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom:
                    ScreenUtil().setWidth(80) + Application.bottomBarHeight),
            child: CustomScrollView(
              slivers: <Widget>[
                PlayListAppBarWidget(
                  sigma: 20,
                  playOnTap: (model) {
                    // playSongs(model, 0);
                  },
                  content: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(35),
                        right: ScreenUtil().setWidth(35),
                        top: ScreenUtil().setWidth(120),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              PlayListCoverWidget(
                                '${widget.data.cover}',
                                width: 250,
                                playCount: widget.data.id,
                              ),
                              HEmptyView(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      widget.data.name,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: mWhiteBoldTextStyle,
                                    ),
                                    VEmptyView(10),
                                    Row(
                                      children: <Widget>[
                                        widget.data == null
                                            ? Container()
                                            : RoundImgWidget(
                                                '${widget.data.cover}', 40),
                                        HEmptyView(5),
                                        Expanded(
                                          child: widget.data == null
                                              ? Container()
                                              : Text(
                                                  widget.data.artist.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: commonWhite70TextStyle,
                                                ),
                                        ),
                                        widget.data == null
                                            ? Container()
                                            : Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.white70,
                                              ),
                                      ],
                                    ),
                                    VEmptyView(10),
                                    buildDescription(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          VEmptyView(15),
                        ],
                      ),
                    ),
                  ),
                  expandedHeight: _expandedHeight,
                  backgroundImg: widget.data.cover,
                  title: widget.data.name,
                  count: widget.data.songs == null
                      ? null
                      : widget.data.songs.length,
                ),
             
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  Widget buildDescription() {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return PlayListDescDialog(widget.data);
          },
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 150),
          transitionBuilder: _buildMaterialDialogTransitions,
        );
      },
      child: widget.data != null && widget.data.detail != null
          ? Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.data.detail,
                    style: smallWhite70TextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white70,
                ),
              ],
            )
          : Container(),
    );
  }
}
