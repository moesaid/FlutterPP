import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeFontfamilyController extends GetxController {
  final _activeFontFamily = GoogleFonts.roboto().obs;
  TextStyle get activeFontFamily => _activeFontFamily.value;

  final _preActiveFontFamily = GoogleFonts.roboto().obs;
  TextStyle get preActiveFontFamily => _preActiveFontFamily.value;

  final _fontKey = ''.obs;
  String get fontKey => _fontKey.value;

  // search result
  final _searchResult = <GoogleFonts>[].obs;
  List<GoogleFonts> get searchResult => _searchResult;

  // cjange font family
  void changeFontFamily({
    String? key,
  }) {
    _preActiveFontFamily.value = GoogleFonts.getFont(key!);
    _fontKey.value = key;
    update();
  }

  // save font family
  void saveFontFamily({required void Function(String)? callback}) {
    _activeFontFamily.value = _preActiveFontFamily.value;

    // callback
    callback?.call(fontKey);

    Get.back();
  }

  // cancle font family
  onCancle() {
    _preActiveFontFamily.value = _activeFontFamily.value;

    Get.back();
  }

  // on search font family
  // searchFontFamily({required String search}) {
  //   if (search.isEmpty) {
  //     _searchResult.clear();
  //     update();
  //     return;
  //   }

  //   _searchResult.clear();
  //   List<GoogleFonts> localSearchResult = [];

  //   for (var element in GoogleFonts.asMap().entries) {
  //     if (element.key.toLowerCase().contains(search.toLowerCase())) {
  //       // format font family to GoogleFonts.fontFamily()
  //       String fontFamily = element.key.camelCase!;

  //       // maching font family
  //       localSearchResult.add(GoogleFonts.getFont(fontFamily));
  //     }
  //   }

  //   _searchResult.addAll(localSearchResult);
  //   update();

  //   print(_searchResult);
  // }
}
