import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/model/album.dart';
import 'package:fskymusic/utils/utils.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/rounded_net_image.dart';
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_tag.dart';

import '../../application.dart';

class PlayListDescDialog extends StatelessWidget {
  final Datum _data;

  PlayListDescDialog(this._data);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: <Widget>[
            Utils.showNetImage(
              '${_data.cover}',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 30,
                sigmaX: 30,
              ),
              child: Container(
                color: Colors.black38,
              ),
            ),
            SafeArea(
              bottom: false,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: ScreenUtil().setWidth(40),
                    top: ScreenUtil().setWidth(10),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: ScreenUtil().setWidth(60),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(100)),
                      child: Column(
                        children: <Widget>[
                          VEmptyView(150),
                          Align(
                            alignment: Alignment.topCenter,
                            child: RoundedNetImage(
                              '${_data.cover}',
                              width: 400,
                              height: 400,
                              fit: BoxFit.fill,
                            ),
                          ),
                          VEmptyView(40),
                          Text(
                            _data.name,
                            textAlign: TextAlign.center,
                            style: mWhiteBoldTextStyle,
                            softWrap: true,
                          ),
                          VEmptyView(40),
                          Image.asset(
                            'images/icon_line_1.png',
                            width: Application.screenWidth * 3 / 4,
                          ),
                          VEmptyView(20),
                          _data.artist.name.isEmpty
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Info --',
                                      style: common14WhiteTextStyle,
                                    ),
                                    TagWidget(_data.artist.name),
                                  ],
                                ),
                          _data.artist.name.isEmpty
                              ? Container()
                              : VEmptyView(40),
                          Text(
                            _data.about,
                            style: common14WhiteTextStyle,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
