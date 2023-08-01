import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:kpop_shop/models/album_model.dart';
import 'package:kpop_shop/providers/user_provider.dart';
import 'package:kpop_shop/utils/ip.dart';
import 'package:http/http.dart' as http;
import 'package:kpop_shop/helper/error_handling.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class CartService{
//----------------------------add to cart---------------------------
  void addToCart(BuildContext context, Album album, double quantity) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart/$quantity'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': album.id}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
          userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //-----------------------remove from cart
  void removeFromCart({
    required BuildContext context,
    required Album album,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${album.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
          userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

}