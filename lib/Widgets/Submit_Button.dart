import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  var _onPressed;
  SubmitButton(this._onPressed);
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: FlatButton(
        minWidth: width * height / 3000,
        color: Colors.red,
        textColor: Colors.white,
        onPressed: _onPressed,
        child: Text(Localization.of(context).getTranslatedValue("SUBMIT")),
      ),
    );
  }
}
