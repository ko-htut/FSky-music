import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fskymusic/model/artistdata.dart';
import 'package:fskymusic/utils/net.dart';

class ArticProvider extends ChangeNotifier {
  String message;
  ArtistDData articd = ArtistDData();

  bool loading = true;

  gethmovie(String id) async {
    setLoading(true);
    getdartist(id).then((aticn) {
      setmmovie(aticn);
      setLoading(false);
    }).catchError((e) {
      throw (e);
    });
  }

  void setMessage(value) {
    message = value;
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
    );
    notifyListeners();
  }

  String getMessage() {
    return message;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setmmovie(value) {
    articd = value;
    notifyListeners();
  }

  ArtistDData getmmovie() {
    return articd;
  }

 
}
