import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/model/artist.dart';
import 'package:fskymusic/utils/navigator_util.dart';
import 'package:fskymusic/utils/net_utils.dart';
import 'package:fskymusic/widget/widget_artists.dart';
import 'package:fskymusic/widget/widget_play.dart';
import 'package:fskymusic/widget/widget_play_list_app_bar.dart';
import 'package:fskymusic/widget/widget_sliver_future_builder.dart';

class ArtistListPage extends StatefulWidget {
  ArtistListPage({Key key}) : super(key: key);

  @override
  _ArtistListPageState createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage> {
  double _expandedHeight = ScreenUtil().setWidth(340);
  int _count;
  ArtistData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom:
                    ScreenUtil().setWidth(100) + Application.bottomBarHeight),
            child: CustomScrollView(
              slivers: <Widget>[
                PlayListAppBarWidget(
                  backgroundImg: 'images/bg_daily.png',
                  count: _count,
                  playOnTap: (model) {
                    // playSongs(model, 0);
                  },
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                        child: Text(
                          'Recommend good music for you according to your music taste.',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  expandedHeight: _expandedHeight,
                  title: 'FSky Artist',
                ),
                CustomSliverFutureBuilder<ArtistData>(
                  futureFunc: NetUtils.getartist,
                  builder: (context, data) {
                    setCount(data.data.length);
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          this.data = data;
                          var d = data.data[index];
                          return InkWell(
                            onTap: (){
                                 
                                NavigatorUtil.goArtistHandler(context,data: data.data[index]);
                            },
                            child: ArtistsWidget(
                              picUrl: d.profile,
                              name: d.name,
                              accountId: d.id,
                            ),
                          );
                        },
                        childCount: data.data.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          PlayWidget(),
        ],
      ),
    );
  }

  void setCount(int count) {
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _count = count;
        });
      }
    });
  }
}
