import 'package:flutter/material.dart';
import 'package:kpop_shop/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    phone: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  // В целом, создание приватной переменной и предоставление
  // публичного геттера - это хороший подход, который обеспечивает
  // инкапсуляцию данных, безопасность, гибкость и возможность
  // уведомления об изменениях.

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
    //информацию о юзере нам нужно передавать по всему приложению
    //поэтому мы создали для него отдельный провайдер
    //в этом провайдере мы храним в _user информацию о юзере
    //а получаем мы ее с помощью setUser. сначала используем
    //функцию декода из класса User(STRING ПОТОМУ ЧТО ЖСОН ДАТА
    // ЭТО ОДИН БОЛЬШОЙ СТРИНГ ТЫ ТУПОРЫЛИК), а потом передаем
    //ретерн (ТИП - ФАКТОРИ разберись с этим конструктором иллюминатов
    // и как он присвает каждый объект параметру юзера )
    // этой функции в наш _user из userprovider и уведомляем все виджеты
    //изи епта
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
