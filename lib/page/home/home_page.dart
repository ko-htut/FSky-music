import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/page/home/my_home/my_home.dart';
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_play.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
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
                        padding: EdgeInsets.only(
                            right: ScreenUtil().setWidth(300)),
                        child: TabBar(
                          labelStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 14),
                          indicator: UnderlineTabIndicator(),
                          controller: _tabController,
                          tabs: [
                            Tab(
                              text: 'Home',
                            ),
                            Tab(
                              text: 'Artic',
                            ),
                            Tab(
                              text: 'Profile',
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: ScreenUtil().setWidth(20),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: ScreenUtil().setWidth(50),
                            color: Colors.black87,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  VEmptyView(20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [MyHome(), Text("Hello 2"), Text("Hello 3")],
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
