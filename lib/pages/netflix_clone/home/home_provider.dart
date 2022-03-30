import 'package:flutter/cupertino.dart';

class NetflixHomeProvider with ChangeNotifier {

  int count = 0;

  void updateCount() {
    count += 1;
    notifyListeners();
  }
}