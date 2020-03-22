import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/model/album.dart';
import 'package:fskymusic/model/song.dart';
import 'package:fskymusic/model/my_song.dart' as son;
import 'package:fskymusic/provider/play_songs_model.dart';
import 'package:fskymusic/utils/navigator_util.dart';
import 'package:fskymusic/utils/net_utils.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/h_empty_view.dart';
import 'package:fskymusic/widget/rounded_net_image.dart';
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_future_builder.dart';
import 'package:fskymusic/widget/widget_play_list.dart';
import 'package:fskymusic/widget/widget_round_img.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Widget _buildHomeCategoryList() {
    var map = {
      'Categories': 'images/icon_playlist.png',
      'Artist': 'images/icon_playlist.png',
      'Facebook': 'images/fskylogo.png',
    };

    var keys = map.keys.toList();
    var width = ScreenUtil().setWidth(80);

    return GridView.custom(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: keys.length,
        childAspectRatio: 1 / 0.4,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              switch (index) {
                case 0:
                  break;
                case 1:
                  NavigatorUtil.goArtistlistHandler(context);
                  break;
              }
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      map[keys[index]],
                      width: width,
                      height: width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Marquee(child: Text(keys[index])),
                  )
                ],
              ),
            ),
          );
        },
        childCount: keys.length,
      ),
    );
  }

  SongData data;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://wallpaperaccess.com/full/1525073.jpg")),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  VEmptyView(15),
                  _buildHomeCategoryList(),
                  VEmptyView(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Song',
                        style: commonTextStyle,
                      ),
                      InkWell(
                        onTap: () {
                          NavigatorUtil.goAllSongPageHandler(context);
                        },
                        child: Text(
                          'See All',
                          style: commonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            VEmptyView(20),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: _buildPlayList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Album',
                    style: commonTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      NavigatorUtil.goAllAlbumPage(context);
                    },
                    child: Text(
                      'See All',
                      style: commonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            VEmptyView(0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildNewAlbum(),
            ),
            VEmptyView(50),
          ],
        ),
      ),
    );
  }

  Widget _buildNewAlbum() {
    return CustomFutureBuilder<AlbumData>(
        futureFunc: NetUtils.getAlbumData,
        builder: (context, snapshot) {
          var data = snapshot.data;
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1 / 1.2),
            itemBuilder: (context, index) {
              var d = data[index];
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  NavigatorUtil.goAlbumPage(context, data: data[index]);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        RoundedNetImage(
                          '${d.cover}',
                          width: 220,
                          height: 230,
                          radius: 15,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          child: Text(
                            d.name,
                            style: smallWhiteTextStyle,
                          ),
                          left: ScreenUtil().setWidth(10),
                          bottom: ScreenUtil().setWidth(10),
                        )
                      ],
                    ),
                    VEmptyView(10),
                    Container(
                      child: Text(
                        d.artist.name,
                        style: common13TextStyle,
                      ),
                      width: ScreenUtil().setWidth(200),
                    ),
                  ],
                ),
              );
            },
            itemCount: 6,
          );
        });
  }

  Widget _buildPlayList() {
    return CustomFutureBuilder<SongData>(
      futureFunc: NetUtils.getSongData,
      builder: (context, snapshot) {
        data = snapshot;
        return Consumer<PlaySongsModel>(builder: (context, model, child) {
          return Container(
              height: ScreenUtil().setWidth(300),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return HEmptyView(ScreenUtil().setWidth(30));
                },
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                itemBuilder: (context, index) {
                  return PlayListWidget(
                    text: snapshot.data[index].name,
                    picUrl: snapshot.data[index].cover,
                    playCount: snapshot.data[index].id,
                    maxLines: 2,
                    onTap: () {
                      playSongs(model, index);
                    },
                  );
                },
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
              ));
        });
      },
    );
  }

  void playSongs(PlaySongsModel model, int index) {
    print(data.data[index].source);
    model.playSongs(
      data.data
          .map((r) => son.Song(r.id,
              songLrc: r.lyric,
              name: r.name,
              picUrl: r.cover,
              artists: '${r.artist.artistName}',
              songUrl:
                  "http://dashboard.fskymusic.com/source/song/mp3/849234502.mp3"))
          .toList(),
      index: index,
    );

    NavigatorUtil.goPlaySongsPage(context);
  }

  @override
  bool get wantKeepAlive => true;
}
