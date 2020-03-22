import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/provider/user_model.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/h_empty_view.dart';
import 'package:fskymusic/widget/widget_round_img.dart';
import 'package:provider/provider.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String vip;
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.initUser();

    return Scaffold(
        body: Container(
      width: Application.screenWidth,
      height: ScreenUtil().setWidth(110) + Application.bottomBarHeight,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.blue[200])),
          color: Colors.white),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
      child: Container(
        width: Application.screenWidth,
        height: ScreenUtil().setWidth(110),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            RoundImgWidget(
                "https://scontent.frgn10-1.fna.fbcdn.net/v/t1.0-9/88335999_195188311743213_6783512510268964864_n.jpg?_nc_cat=102&_nc_sid=85a577&_nc_ohc=RGLMhP5XMMQAX_XpPiq&_nc_ht=scontent.frgn10-1.fna&oh=d5f733ebd356d0805af746d403b7661a&oe=5E9B9343",
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
                      userModel.user.success.details.vip != 0
                          ? Icon(
                              Icons.verified_user,
                              size: 20,
                              color: Colors.teal,
                            )
                          : Icon(
                              Icons.not_listed_location,
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
    )
    );
  }
}
