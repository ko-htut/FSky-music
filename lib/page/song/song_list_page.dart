import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/model/music.dart';
import 'package:fskymusic/model/song.dart';
import 'package:fskymusic/provider/play_songs_model.dart';
import 'package:fskymusic/utils/navigator_util.dart';
import 'package:fskymusic/utils/net_utils.dart';
import 'package:fskymusic/widget/widget_music_list_item.dart';
import 'package:fskymusic/widget/widget_play.dart';
import 'package:fskymusic/model/my_song.dart' as son;
import 'package:fskymusic/widget/widget_play_list_app_bar.dart';
import 'package:fskymusic/widget/widget_sliver_future_builder.dart';
import 'package:provider/provider.dart';

class SongPlayListPage extends StatefulWidget {
  SongPlayListPage({Key key}) : super(key: key);

  @override
  _SongPlayListPageState createState() => _SongPlayListPageState();
}

class _SongPlayListPageState extends State<SongPlayListPage> {
  double _expandedHeight = ScreenUtil().setWidth(340);
  int _count;
  SongData data;

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
                    playSongs(model, 0);
                  },
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      '${DateUtil.formatDate(DateTime.now(), format: 'dd')} ',
                                  style: TextStyle(fontSize: 30)),
                              TextSpan(
                                  text:
                                      '/ ${DateUtil.formatDate(DateTime.now(), format: 'MM')}',
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
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
                  title: 'F-Sky Music',
                ),
                CustomSliverFutureBuilder<SongData>(
                  futureFunc: NetUtils.getSongData,
                  builder: (context, data) {
                    setCount(data.data.length);
                    return Consumer<PlaySongsModel>(
                      builder: (context, model, child) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              this.data = data;
                              var d = data.data[index];
                              return WidgetMusicListItem(
                                MusicData(
                                    mvid: d.id,
                                    picUrl: d.cover,
                                    songName: d.name,
                                    artists:
                                        "${d.artist.artistName} - ${d.album.albumName}"),
                                onTap: () {
                                  playSongs(model, index);
                                },
                              );
                            },
                            childCount: data.data.length,
                          ),
                        );
                      },
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

  void playSongs(PlaySongsModel model, int index) {
    model.playSongs(
      data.data
          .map((r) => son.Song(r.id,
              songLrc: r.lyric,
              name: r.name,
              picUrl: r.cover,
              artists: '${r.artist.artistName}',
              songUrl:
                  "https://eboxmovie.sgp1.digitaloceanspaces.com/saisai.MP3"))
          .toList(),
      index: index,
    );

    NavigatorUtil.goPlaySongsPage(context);
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
