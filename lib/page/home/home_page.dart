import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/page/home/my_home/my_home.dart';
import 'package:fskymusic/page/home/my_page/my_page.dart';
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_play.dart';

import 'about/about.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
        ),
        preferredSize: Size.zero,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Padding(
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(right: ScreenUtil().setWidth(280)),
                        child: TabBar(
                          labelStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 13),
                          indicator: UnderlineTabIndicator(),
                          controller: _tabController,
                          tabs: [
                            Tab(
                              text: 'Home',
                            ),
                            Tab(
                              text: 'My Page',
                            ),
                            // Tab(
                            //   text: 'Profile',
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: ScreenUtil().setWidth(20),
                        child: Image.asset(
                          'images/fskylogo.png',
                          width: ScreenUtil().setWidth(90),
                          height: ScreenUtil().setWidth(90),
                        ),
                      ),
                    ],
                  ),
                  VEmptyView(20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [MyHome(), MyPage()],
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                  bottom:
                      ScreenUtil().setWidth(0) + Application.bottomBarHeight),
            ),
            PlayWidget(),
          ],
        ),
      ),
    );
  }
}
