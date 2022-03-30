import 'package:flutter/cupertino.dart';

class ImageDetailProvider with ChangeNotifier {

  String _currentImgUrl = '';
  List<String> _imageUrls = <String>[];

  String get currentImgUrl => _currentImgUrl;

  set currentImgUrl(String value) {
    _currentImgUrl = value;
    notifyListeners();
  }

  List<String> get imageUrls => _imageUrls;

  set imageUrls(List<String> value) {
    _imageUrls = value;
    notifyListeners();
  }

  int get currentPageIndex => _calculateCurrentIndex();

  void onPageChanged(int index) {
    _currentImgUrl = _imageUrls[index];
  }

  int _calculateCurrentIndex() {
    return _imageUrls.indexOf(_currentImgUrl);
  }
}