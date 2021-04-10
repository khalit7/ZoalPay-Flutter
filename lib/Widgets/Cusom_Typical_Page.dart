import 'package:ZoalPay/Widgets/Custom_Flat_Button.dart';
import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {
  var title, text, hinttext, buttontext, check, button, customOnPressed;
  BasicPage(this.title, this.text, this.hinttext, this.buttontext,
      this.customOnPressed, this.check);

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (check) {
      button = CustomFlatButton1(width, height, buttontext, () {
        customOnPressed();
      }, 1500, 18.0);
    } else {
      button = CustomFlatButton2(width, height, buttontext, () {
        customOnPressed();
      }, 1500, 18.0);
    }
    var appBar = AppBar(title: Text(title));
    height -= appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: Container(
          width: width,
          height: height / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.3,
                  ),
                  padding: EdgeInsets.fromLTRB(
                      width / 9, height / 30, width / 9, 0)),
              SizedBox(
                height: height / 12,
              ),
              Row(children: [
                SizedBox(
                  width: width / 15,
                ),
                SizedBox(
                  width: width - (width / 15),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: hinttext,
                    ),
                  ),
                ),
              ]),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      width / 4.2, height / 40, width / 4.2, 0),
                  child: button)
            ],
          )),
    );
  }
}
