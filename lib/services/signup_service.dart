import 'package:flutter/cupertino.dart';
import 'package:kpop_shop/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:kpop_shop/helper/error_handling.dart';
import 'package:kpop_shop/utils/ip.dart';

class SignUpService {
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String phone,
      required String name}) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          email: email,
          address: '',
          phone: phone,
          type: '',
          token: '',
      cart: [],);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created. Login with the same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
