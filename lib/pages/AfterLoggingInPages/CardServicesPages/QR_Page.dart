import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:qr_flutter/qr_flutter.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:share/share.dart';

class QRPage extends StatefulWidget {
  static final pageName = "QRPage";

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  var _controller1 = TextEditingController();
  List<CardModel> cards;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("QR Code"),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[300],
          ),
          //card number box
          Positioned(
            left: width / 10,
            right: width / 10,
            top: height / 30,
            bottom: height / 1.3,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    Localization.of(context).getTranslatedValue("Card Number"),
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  subtitle: Text(_controller1.text),
                  trailing: PopupMenuButton(
                      itemBuilder: (BuildContext context) => cards
                          .map((card) => PopupMenuItem(
                                child: Text(card.cardUserName),
                                value: card.cardUserName,
                              ))
                          .toList(),
                      onSelected: (value) {
                        setState(() {
                          _controller1.text = value;
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down)),
                )),
          ),
          //Qr Image
          Positioned(
              left: width / 10,
              right: width / 10,
              top: height / 7,
              bottom: height / 2.9,
              child: Container(
                decoration: ShapeDecoration(
                    shape: Border.all(width: 1, color: Colors.white),
                    color: Colors.white),
              )
              // child: QrImage(
              //   data: _controller1.text,
              //   size: width * height / 1000,
              // ))),
              //share button
              ),
          Positioned(
              left: width / 1.3,
              right: width / 20,
              top: height / 1.3,
              bottom: height / 40,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share("hi");
                  },
                  color: Colors.white,
                ),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              )),
        ],
      ),
    );
  }
}
