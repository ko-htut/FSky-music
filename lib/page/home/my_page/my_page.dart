import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/page/home/about/about.dart';
import 'package:fskymusic/provider/user_model.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/h_empty_view.dart';
import 'package:fskymusic/widget/widget_round_img.dart';
import 'package:provider/provider.dart';

import '../../../application.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  Map<String, String> topMenuData = {
    'History': 'images/icon_late_play.png',
    'Download': 'images/icon_download_black.png',
    'About F-Sky': 'images/fskylogo.png',
  };

  List<String> topMenuKeys;
  bool selfPlayListOffstage = false;
  bool collectPlayListOffstage = false;

  @override
  void initState() {
    super.initState();
    topMenuKeys = topMenuData.keys.toList();
  }

  Widget _buildTopMenu() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var curKey = topMenuKeys[index];
        var curValue = topMenuData[topMenuKeys[index]];
        return Container(
          height: ScreenUtil().setWidth(110),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(140),
                child: Align(
                  child: Image.asset(
                    curValue,
                    width: ScreenUtil().setWidth(100),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  curKey,
                  style: commonTextStyle,
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.grey,
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
          height: ScreenUtil().setWidth(0.3),
        );
      },
      itemCount: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.initUser();
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: Application.screenWidth,
              height: ScreenUtil().setWidth(110) + Application.bottomBarHeight,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.blue[200])),
                  color: Colors.white),
              alignment: Alignment.topCenter,
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              child: Container(
                width: Application.screenWidth,
                height: ScreenUtil().setWidth(110),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    RoundImgWidget(
                        "images/prof.png",
                        80),
                    HEmptyView(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                userModel.user.success.details.name,
                                style: commonTextStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // userModel.user.success.details.vip
                              userModel.user.success.details.vip == "1"
                                  ? Icon(
                                      Icons.verified_user,
                                      size: 20,
                                      color: Colors.teal,
                                    )
                                  : Icon(
                                      Icons.verified_user,
                                      size: 20,
                                    )
                            ],
                          ),
                          Text(
                            userModel.user.success.details.email,
                            style: common13TextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xfff5f5f5),
              height: ScreenUtil().setWidth(25),
            ),
            _buildTopMenu(),
            Container(
              color: Color(0xfff5f5f5),
              height: ScreenUtil().setWidth(25),
            ),
            Container(
              height: ScreenUtil().setWidth(400),
              alignment: Alignment.center,
              child: CupertinoActivityIndicator(),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
