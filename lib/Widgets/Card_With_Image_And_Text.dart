import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  String imageName;
  String text;
  var onpressed;
  ServiceWidget({this.imageName, this.text, this.onpressed});
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, width / 36, 0, width / 36),
      child: Container(
        width: width / 3.5,
        height: width / 3.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          highlightColor: Colors.red,
          onTap: onpressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage("assets/icons/" + imageName),
                color: Colors.red,
                size: width / 12,
              ),
              Text(
                Localization.of(context).getTranslatedValue(text),
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
