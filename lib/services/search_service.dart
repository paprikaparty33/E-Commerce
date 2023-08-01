import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';
import '../providers/user_provider.dart';
import '../helper/error_handling.dart';
import '../utils/ip.dart';

class SearchService {
  //get normal search
  Future<List<Album>> fetchSearch(
      BuildContext context, String searchQuery) async {
    List<Album> albumList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/albums/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

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
    }
    return albumList;
  }

  //get category search
  Future<List<Album>> fetchCategorySearch(
      BuildContext context, String searchQuery, String searchCategory) async {
    List<Album> albumList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/albums/search/$searchQuery/$searchCategory'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });

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
