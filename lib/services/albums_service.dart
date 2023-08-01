import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:kpop_shop/models/album_model.dart';
import 'package:kpop_shop/providers/user_provider.dart';
import 'package:kpop_shop/utils/ip.dart';
import 'package:http/http.dart' as http;
import 'package:kpop_shop/helper/error_handling.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class AlbumService {

  //------------------------------------get new arrivals--------------------------
  Future<List<Album>> fetchNewArrivals(BuildContext context) async {
    List<Album> albumList = [];

    try {
      http.Response res = await http.get(Uri.parse('$uri/get-new-arrivals'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              albumList.add(Album.fromJson(jsonEncode(
                jsonDecode(res.body)[i],
              )));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return albumList;
  }

  //-------------------------get popular---------------------------
  Future<List<Album>> fetchPopular(BuildContext context) async {
    List<Album> albumList = [];
    try {
      http.Response res = await http.get(Uri.parse('$uri/get-popular'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              albumList.add(Album.fromJson(jsonEncode(
                jsonDecode(res.body)[i],
              )));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return albumList;
  }

  //----------------------------get based on category--------------------
  Future<List<Album>> fetchCategory(
      BuildContext context, String category) async {
    List<Album> albumList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/get-category?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print(res.body);
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              albumList.add(Album.fromJson(jsonEncode(
                jsonDecode(res.body)[i],
              )));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return albumList;
  }

  Future<List<Album>> fetchAll(BuildContext context) async {
    List<Album> albumList = [];
    try {
      http.Response res = await http.get(Uri.parse('$uri/get-all'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              albumList.add(Album.fromJson(jsonEncode(
                jsonDecode(res.body)[i],
              )));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return albumList;
  }

}
