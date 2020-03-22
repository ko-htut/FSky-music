import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/widget/widget_round_img.dart';

import 'common_text_style.dart';
import 'h_empty_view.dart';

class ArtistsWidget extends StatelessWidget {
  final String picUrl;
  final String name;
  final int accountId;

  const ArtistsWidget({Key key, this.picUrl, this.name, this.accountId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
      child: Row(
        children: <Widget>[
           HEmptyView(10),
          RoundImgWidget(
            '$picUrl',
            120,
            fit: BoxFit.cover,
          ),
          HEmptyView(10),
          Text(name),
          Spacer(),
          accountId == null || accountId == 0
              ? Container()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.red,
                        size: ScreenUtil().setWidth(30),
                      ),
                    ),
                    HEmptyView(5),
                  ],
                ),
                 HEmptyView(10),
        ],
      ),
    );
  }
}
