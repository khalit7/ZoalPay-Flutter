import 'package:flutter/material.dart';

class CardWithImageAndText extends StatelessWidget {
  var image, text;
  CardWithImageAndText(this.image, this.text);
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, width / 36, 0, width / 36),
      child: Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          width: width / 3.5,
          height: width / 3.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [image, text],
          ),
        ),
      ),
    );
  }
}
