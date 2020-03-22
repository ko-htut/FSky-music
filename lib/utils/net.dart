import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fskymusic/model/artistdata.dart';
import 'package:fskymusic/widget/loading.dart';

final String baseUrl = 'http://dashboard.fskymusic.com/api/';

Future<ArtistDData> getdartist(String ids) async {
  Response response = await dio.Dio().get(ids);
  return ArtistDData.fromJson(response.data);
}
