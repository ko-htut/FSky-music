import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/provider/play_songs_model.dart';

import 'package:provider/provider.dart';

import 'common_text_style.dart';
import 'h_empty_view.dart';

typedef PlayModelCallback = void Function(PlaySongsModel model);

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  MusicListHeader({this.count, this.tail,this.title, this.onTap});

  final int count;
  final Widget tail;
  final String title;
  final PlayModelCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenUtil().setWidth(30))),
      child: Container(
        color: Colors.white,
        child: Consumer<PlaySongsModel>(builder: (context, model, child) {
          return InkWell(
            onTap: (){
              onTap(model);
            },
            child: SizedBox.fromSize(
              size: preferredSize,
              child: Row(
                children: <Widget>[
                  HEmptyView(20),
                  Icon(
                    Icons.play_circle_outline,
                    size: ScreenUtil().setWidth(50),
                  ),
                  HEmptyView(10),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      title,
                      style: mCommonTextStyle,
                    ),
                  ),
                  HEmptyView(5),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: count == null
                        ? Container()
                        : Text(
                            "($count)",
                            style: smallGrayTextStyle,
                          ),
                  ),
                  Spacer(),
                  tail ?? Container(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setWidth(100));
}
