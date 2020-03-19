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
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_future_builder.dart';
import 'package:fskymusic/widget/widget_play_list.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Widget _buildHomeCategoryList() {
    return Container(
      height: 120,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                 height: 100,
                    width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.green, BlendMode.softLight),
                    fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://avatarfiles.alphacoders.com/954/95487.png",scale: 30)),
              
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.dialpad),
            ),
          ),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Container(
          //           color: Colors.black12,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("Artis"),
          //           ),
          //         ),
          //         Container(
          //           color: Colors.black12,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("Category"),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Container(
          //           color: Colors.black12,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("data"),
          //           ),
          //         ),
          //         Container(
          //           color: Colors.black12,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("data"),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Container(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("data"),
          //           ),
          //         ),
          //         Container(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("data"),
          //           ),
          //         )
          //       ],
          //     ),
          //   )
        ],
      ),
    );
  }

  SongData data;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 180,
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
                  Text(
                    'Album',
                    style: commonTextStyle,
                  ),
                ],
              ),
            ),
            VEmptyView(20),
            _buildNewAlbum(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
              ),
              child: Text(
                'Song',
                style: commonTextStyle,
              ),
            ),
            VEmptyView(20),
            _buildPlayList(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
              ),
              child: Text(
                'MV',
                style: commonTextStyle,
              ),
            ),
            VEmptyView(20),
            _buildNewAlbum(),
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
                    text: data[index].name,
                    picUrl: data[index].cover,
                    subText: data[index].name ?? "",
                    maxLines: 1,
                    onTap: () {
                      NavigatorUtil.goAlbumPage(context, data: data[index]);
                    },
                  );
                },
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
              ));
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
    model.playSongs(
      data.data
          .map((r) => son.Song(r.id,
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

  @override
  bool get wantKeepAlive => true;
}
