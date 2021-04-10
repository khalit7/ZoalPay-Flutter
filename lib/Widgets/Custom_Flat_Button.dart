import 'package:flutter/material.dart';
//red background and white text
class CustomFlatButton1 extends StatelessWidget {
  var width, height, myOnPressed, text, size;
  double radius;
  CustomFlatButton1(this.width, this.height, this.text, this.myOnPressed,
      this.size, this.radius);
  build(context) {
    return FlatButton(
      minWidth: width * height / size,
      color: Colors.red,
      textColor: Colors.white,
      onPressed: () {
        myOnPressed();
      },
      child: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// red text and white background
class CustomFlatButton2 extends StatelessWidget {
  var width, height, myOnPressed, text, size;
  double radius;
  CustomFlatButton2(this.width, this.height, this.text, this.myOnPressed,
      this.size, this.radius);
  build(context) {
    return FlatButton(
      minWidth: width * height / size,
      textColor: Colors.red,
      onPressed: () {
          myOnPressed();
      },
      child: Text(text,style: TextStyle(fontSize:width/31 ),),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
//white text with white backGround
class CustomFlatButton3 extends StatelessWidget {
  var width, height, myOnPressed, text, size;
  double radius;
  CustomFlatButton3(this.width, this.height, this.text, this.myOnPressed,
      this.size, this.radius);
  build(context) {
    return FlatButton(
      minWidth: width * height / size,
      textColor: Colors.white,
      onPressed: () {
          myOnPressed();
      },
      child: Text(text,style: TextStyle(fontSize:width/31 ),),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
