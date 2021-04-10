import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  static final pageName = "FavouritesPage";

  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).getTranslatedValue("Favourites")),
      ),
    );
  }
}
