import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:kpop_shop/models/album_model.dart';
import 'package:kpop_shop/providers/user_provider.dart';
import 'dart:io';
import 'package:kpop_shop/utils/ip.dart';
import 'package:http/http.dart' as http;
import 'package:kpop_shop/helper/error_handling.dart';
import 'package:provider/provider.dart';

import '../pages/auth/sign_in_page.dart';
import '../pages/home/admin_home_page.dart';

class AdminService {
  //AddProduct
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String location,
      required String status,
      required List<File> images,
      required bool isNewArrival,
      required bool isPopular,
      required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dcwtqagpp', 'mwi0gxzr');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      Album album = Album(
          isPopular: isPopular,
          category: category,
          price: price,
          quantity: quantity,
          location: location,
          status: status,
          description: description,
          images: imageUrls,
          name: name,
          isNewArrival: isNewArrival);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-album'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: album.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Album added');
          });
    } catch (e) {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' + e.toString());
    }
  }

  void updateProduct(
      {required BuildContext context,
      required String id,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String location,
      required String status,
      required List<String> images,
      required bool isNewArrival,
      required bool isPopular,
      required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Album album = Album(
          id: id,
          isPopular: isPopular,
          category: category,
          price: price,
          quantity: quantity,
          location: location,
          status: status,
          description: description,
          images: images,
          name: name,
          isNewArrival: isNewArrival);
      http.Response res = await http.put(
        Uri.parse('$uri/admin/update-album'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: album.toJson(),
      );
      print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Album updated');
            Navigator.of(context).pop();
          });
    } catch (e) {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' + e.toString());
    }
  }



  void deleteProduct(
      {required BuildContext context,
      required Album album}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-album'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          '_id': album.id,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Album deleted');
            Navigator.of(context).pushNamed(AdminHomePage.routeName);

          });
    } catch (e) {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' + e.toString());
    }
  }
}
