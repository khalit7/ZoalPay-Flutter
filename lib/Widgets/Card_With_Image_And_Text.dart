import 'package:flutter/material.dart';

class CardWithImageAndText extends StatelessWidget {
  var image, text;
  CardWithImageAndText(this.image, this.text);
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 2.01,
      height: width / 2.01,
      child: Card(
        elevation: 10,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [image, text],
        ),
      ),
    );
  }
}
