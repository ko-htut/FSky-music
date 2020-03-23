import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fskymusic/page/play_songs/widget_song_progress.dart';
import 'package:fskymusic/provider/play_songs_model.dart';
import 'package:fskymusic/provider/user_model.dart';
import 'package:fskymusic/utils/navigator_util.dart';
import 'package:fskymusic/utils/utils.dart';
import 'package:fskymusic/widget/common_button.dart';
import 'package:fskymusic/widget/common_text_style.dart';
import 'package:fskymusic/widget/v_empty_view.dart';
import 'package:fskymusic/widget/widget_img_menu.dart';
import 'package:fskymusic/widget/widget_play_bottom_menu.dart';
import 'package:fskymusic/widget/widget_round_img.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../application.dart';
import 'package:toast/toast.dart' as t;

class PlaySongsPage extends StatefulWidget {
  PlaySongsPage({Key key}) : super(key: key);

  @override
  _PlaySongsPageState createState() => _PlaySongsPageState();
}

class _PlaySongsPageState extends State<PlaySongsPage> {
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return Container(
      child: PlaySongsPage1(platform: platform),
    );
  }
}

class PlaySongsPage1 extends StatefulWidget {
  final TargetPlatform platform;

  PlaySongsPage1({Key key, this.platform}) : super(key: key);
  @override
  _PlaySongsPage1State createState() => _PlaySongsPage1State();
}

class _PlaySongsPage1State extends State<PlaySongsPage1>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _stylusController;
  Animation<double> _stylusAnimation;
  int switchIndex = 0;
  bool _isLoading;
  bool _permissionReady;
  String _localPath;
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    _isLoading = true;
    _permissionReady = false;
    _prepare();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _stylusController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _stylusAnimation =
        Tween<double>(begin: -0.03, end: -0.10).animate(_stylusController);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);

    return Builder(
        builder: (context) => _isLoading
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : _permissionReady
                ? new Consumer<PlaySongsModel>(
                    builder: (context, model, child) {
                    var curSong = model.curSong;
                    if (model.curState == AudioPlayerState.PLAYING) {
                      _controller.forward();
                      _stylusController.reverse();
                    } else {
                      _controller.stop();
                      _stylusController.forward();
                    }
                    return Scaffold(
                      body: Stack(
                        children: <Widget>[
                          Utils.showNetImage(
                            '${curSong.picUrl}',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaY: 100,
                              sigmaX: 100,
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
                                  model.curSong.name,
                                  style: commonWhiteTextStyle,
                                ),
                                Text(
                                  model.curSong.artists,
                                  style: smallWhite70TextStyle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: kToolbarHeight +
                                    Application.statusBarHeight),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() {
                                        if (switchIndex == 0) {
                                          switchIndex = 1;
                                        } else {
                                          switchIndex = 0;
                                        }
                                      });
                                    },
                                    child: IndexedStack(
                                      index: switchIndex,
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setWidth(150)),
                                                child: RotationTransition(
                                                  turns: _controller,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      prefix0.Image.asset(
                                                        'images/bet.png',
                                                        width: ScreenUtil()
                                                            .setWidth(550),
                                                      ),
                                                      RoundImgWidget(
                                                          '${curSong.picUrl}',
                                                          370),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              child: RotationTransition(
                                                turns: _stylusAnimation,
                                                alignment: Alignment(
                                                    -1 +
                                                        (ScreenUtil().setWidth(
                                                                45 * 2) /
                                                            (ScreenUtil()
                                                                .setWidth(
                                                                    293))),
                                                    -1 +
                                                        (ScreenUtil().setWidth(
                                                                45 * 2) /
                                                            (ScreenUtil()
                                                                .setWidth(
                                                                    504)))),
                                                child: Image.asset(
                                                  'images/bgm.png',
                                                  width: ScreenUtil()
                                                      .setWidth(205),
                                                  height: ScreenUtil()
                                                      .setWidth(352.8),
                                                ),
                                              ),
                                              alignment: Alignment(0.25, -1),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            model.curSong.songLrc,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                buildSongsHandle(model, userModel),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(30)),
                                  child: SongProgressWidget(model),
                                ),
                                PlayBottomMenuWidget(model),
                                VEmptyView(20),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              'Please grant accessing storage permission to continue -_-',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 18.0),
                            ),
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                          FlatButton(
                              onPressed: () {
                                _checkPermission().then((hasGranted) {
                                  setState(() {
                                    _permissionReady = hasGranted;
                                  });
                                });
                              },
                              child: Text(
                                'Retry',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ))
                        ],
                      ),
                    ),
                  ));
  }

  Widget _buildActionForTask(PlaySongsModel task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return new RawMaterialButton(
        onPressed: () {
          _requestDownload(task);
        },
        child: new Icon(Icons.file_download),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return new RawMaterialButton(
        onPressed: () {
          _pauseDownload(task);
        },
        child: new Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return new RawMaterialButton(
        onPressed: () {
          _resumeDownload(task);
        },
        child: new Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text(
            'Ready',
            style: new TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              _delete(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return new Text('Canceled', style: new TextStyle(color: Colors.red));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text('Failed', style: new TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              _retryDownload(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else {
      return null;
    }
  }

  void _retryDownload(PlaySongsModel task) async {
    String newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  void _delete(PlaySongsModel task) async {
    await FlutterDownloader.remove(
        taskId: task.taskId, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Widget buildSongsHandle(PlaySongsModel model, UserModel userModel) {
    return Container(
      height: ScreenUtil().setWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          userModel.user != null
              ? CommonButton(
                  color: Colors.green,
                  content: "Download",
                  callback: () {
                    t.Toast.show("Start Downloading", context,
                        duration: t.Toast.LENGTH_SHORT,
                        gravity: t.Toast.BOTTOM);
                    _requestDownload(model);
                  },
                )
              : Center(
                  child: CommonButton(
                    color: Colors.green,
                    content: "Donwload",
                    callback: () {
                      return showDialog(
                        context: context,
                        barrierDismissible:
                            false, // user must tap button for close dialog!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Login '),
                            content: const Text('dfskdjfafksdnfkslkajkkdnak'),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('တော်ပီ'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: const Text('Login ဝင်မည်'),
                                onPressed: () {
                                  NavigatorUtil.goLoginPage(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _pauseDownload(PlaySongsModel task) async {
    await FlutterDownloader.pause(taskId: task.taskId);
  }

  void _resumeDownload(PlaySongsModel task) async {
    String newTaskId = await FlutterDownloader.resume(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  void _requestDownload(PlaySongsModel model) async {
    model.curSong.songUrl = await FlutterDownloader.enqueue(
        url: model.curSong.songUrl,
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true);
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();
    _permissionReady = await _checkPermission();

    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> _findLocalPath() async {
    final directory = widget.platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  void dispose() {
    _controller.dispose();
    _stylusController.dispose();
    super.dispose();
    _unbindBackgroundIsolate();
  }
}
