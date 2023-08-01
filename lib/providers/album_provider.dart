import 'package:flutter/material.dart';
import 'package:kpop_shop/models/album_model.dart';
import 'package:kpop_shop/models/user_model.dart';

class AlbumProvider extends ChangeNotifier {

  String _productId = '';

  String? get productId => _productId;

  set productId(String? value) {
    _productId = value!;
    notifyListeners();
  }
  // Album _album = Album(
  //     id: '',
  //     name: '',
  //     quantity: '',
  //     price: '',
  //     description: '',
  //     location: '',
  //     status: '',
  //     images: '',
  //       );
  //
  // Album get album => _album;
  // // В целом, создание приватной переменной и предоставление
  // // публичного геттера - это хороший подход, который обеспечивает
  // // инкапсуляцию данных, безопасность, гибкость и возможность
  // // уведомления об изменениях.
  //
  // void setUser(String user){
  //   _album = Album.fromJson(album.toString());
  //   notifyListeners();
  //   //информацию о юзере нам нужно передавать по всему приложению
  //   //поэтому мы создали для него отдельный провайдер
  //   //в этом провайдере мы храним в _user информацию о юзере
  //   //а получаем мы ее с помощью setUser. сначала используем
  //   //функцию декода из класса User(STRING ПОТОМУ ЧТО ЖСОН ДАТА
  //   // ЭТО ОДИН БОЛЬШОЙ СТРИНГ ТЫ ТУПОРЫЛИК), а потом передаем
  //   //ретерн (ТИП - ФАКТОРИ разберись с этим конструктором иллюминатов
  //   // и как он присвает каждый объект параметру юзера )
  //   // этой функции в наш _user из userprovider и уведомляем все виджеты
  //   //изи епта
  // }
}