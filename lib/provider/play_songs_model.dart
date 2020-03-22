import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:fskymusic/application.dart';
import 'package:fskymusic/model/my_song.dart';
import 'package:fskymusic/utils/fluro_convert_utils.dart';

class PlaySongsModel with ChangeNotifier {
  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  AudioPlayer _audioPlayer = AudioPlayer();
  StreamController<String> _curPositionController =
      StreamController<String>.broadcast();

  List<Song> _songs = [];
  int curIndex = 0;
  Duration curSongDuration;
  AudioPlayerState _curState;

  List<Song> get allSongs => _songs;
  Song get curSong => _songs[curIndex];
  Stream<String> get curPositionStream => _curPositionController.stream;
  AudioPlayerState get curState => _curState;

  void init() {
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _curState = state;

      if (state == AudioPlayerState.COMPLETED) {
        nextPlay();
      }

      notifyListeners();
    });
    _audioPlayer.onDurationChanged.listen((d) {
      curSongDuration = d;
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      sinkProgress(p.inMilliseconds > curSongDuration.inMilliseconds
          ? curSongDuration.inMilliseconds
          : p.inMilliseconds);
    });
  }

  void sinkProgress(int m) {
    _curPositionController.sink.add('$m-${curSongDuration.inMilliseconds}');
  }

  void playSong(Song song) {
    _songs.insert(curIndex, song);
    play();
  }

  void playSongs(List<Song> songs, {int index}) {
    this._songs = songs;
    if (index != null) curIndex = index;
    play();
  }

  void addSongs(List<Song> songs) {
    this._songs.addAll(songs);
  }

  void play() {
    _audioPlayer.play("${this._songs[curIndex].songUrl}");
    saveCurSong();
    notifyListeners();
  }

  void togglePlay() {
    if (_audioPlayer.state == AudioPlayerState.PAUSED) {
      resumePlay();
    } else {
      pausePlay();
    }
  }

  void pausePlay() {
    _audioPlayer.pause();
  }

  void seekPlay(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    resumePlay();
  }

  void resumePlay() {
    _audioPlayer.resume();
  }

  void nextPlay() {
    if (curIndex >= _songs.length) {
      curIndex = 0;
    }
    if (curIndex == _songs.length) {
      pausePlay();
    } else {
      curIndex++;
    }
    _audioPlayer.stop();
    play();
  }

  void prePlay() {
    if (curIndex <= 0) {
      curIndex = _songs.length - 1;
    } else {
      curIndex--;
    }
    play();
  }

  void saveCurSong() {
    Application.sp.remove('playing_songs');
    Application.sp.setStringList('playing_songs',
        _songs.map((s) => FluroConvertUtils.object2string(s)).toList());
    Application.sp.setInt('playing_index', curIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _curPositionController.close();
    _audioPlayer.dispose();
  }
}
