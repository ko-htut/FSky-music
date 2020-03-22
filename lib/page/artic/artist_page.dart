import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/model/albumsong.dart';
import 'package:fskymusic/model/artist.dart';
import 'package:fskymusic/model/artistdata.dart';
import 'package:fskymusic/model/music.dart';
import 'package:fskymusic/provider/artic_provider.dart';
import 'package:fskymusic/provider/play_songs_model.dart';
import 'package:fskymusic/utils/navigator_util.dart';
import 'package:fskymusic/utils/net_utils.dart';
import 'package:fskymusic/utils/utils.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/widget_artists.dart';
import 'package:fskymusic/widget/widget_music_list_item.dart';
import 'package:fskymusic/widget/widget_play.dart';
import 'package:fskymusic/widget/widget_round_img.dart';
import 'package:fskymusic/widget/widget_sliver_future_builder.dart';
import 'package:provider/provider.dart';
import 'package:fskymusic/model/album.dart' as alb;
import 'package:fskymusic/model/albumsong.dart' as ass;
import 'package:fskymusic/model/my_song.dart' as son;

class ArtistPage extends StatefulWidget {
  Datum data;
  ArtistPage({Key key, this.data}) : super(key: key);

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ArticProvider>(context, listen: false)
        .gethmovie(widget.data.detail);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Utils.showNetImage(
              '${widget.data.profile}',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 10,
                sigmaX: 10,
              ),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            AppBar(
              centerTitle: true,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.data.name,
                    style: commonWhiteTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom:
                      ScreenUtil().setWidth(80) + Application.bottomBarHeight),
              child: Container(
                margin: EdgeInsets.only(
                    top: kToolbarHeight + Application.statusBarHeight),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: RoundImgWidget(widget.data.profile, 80),
                        title: Text(
                          widget.data.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TabBar(
                        labelColor: Colors.white,
                        tabs: [
                          Tab(
                            text: "Song",
                          ),
                          Tab(
                            text: "Album",
                          ),
                        ],
                      ),
                      Container(
                          // color: Colors.white,
                          height: MediaQuery.of(context).size.height - 270,
                          child: Consumer<ArticProvider>(builder:
                              (BuildContext context,
                                  ArticProvider movieProvider, Widget widget) {
                            return movieProvider.loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : TabBarView(
                                    children: [
                                      Consumer<PlaySongsModel>(
                                          builder: (context, model, child) {
                                        return ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0),
                                          scrollDirection: Axis.vertical,
                                          itemCount: movieProvider
                                              .articd.data.song.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return WidgetMusicListItem(
                                              MusicData(
                                                  mvid: movieProvider.articd
                                                      .data.song[index].id,
                                                  picUrl: movieProvider.articd
                                                      .data.song[index].cover,
                                                  songName: movieProvider.articd
                                                      .data.song[index].name,
                                                  artists:
                                                      "${movieProvider.articd.data.song[index].artist.artistName}"),
                                              onTap: () {
                                                playSongs(model, movieProvider,
                                                    index);
                                              },
                                            );
                                          },
                                        );
                                      }),
                                      ListView.builder(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        scrollDirection: Axis.vertical,
                                        itemCount: movieProvider
                                            .articd.data.album.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return WidgetMusicListItem(
                                            MusicData(
                                                mvid: movieProvider.articd.data
                                                    .album[index].id,
                                                picUrl: movieProvider.articd
                                                    .data.album[index].cover,
                                                songName: movieProvider.articd
                                                    .data.album[index].name,
                                                artists:
                                                    "${movieProvider.articd.data.album[index].artist.name}"),
                                            onTap: () {
                                              // NavigatorUtil.goAlbumPage(context,
                                              //     data: movieProvider.articd
                                              //         .data.album[index]);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                          }))
                    ],
                  ),
                ),
              ),
            ),
            PlayWidget()
          ],
        ),
      ),
    );
  }

  void playSongs(PlaySongsModel model, ArticProvider movieprovider, int index) {
    model.playSongs(
      movieprovider.articd.data.song
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
}

// class EpisodeProvider {}
