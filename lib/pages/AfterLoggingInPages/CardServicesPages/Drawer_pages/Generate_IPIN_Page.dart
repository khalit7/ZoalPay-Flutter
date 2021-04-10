import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class GenerateIPINPage extends StatelessWidget {
  static final pageName = "GenerateIPINPage";
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu_outlined),
            ),
            SizedBox(width: width / 15),
            Text(
              Localization.of(context).getTranslatedValue("Generate IPIN"),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          //first field text
          SizedBox(
            height: height / 40,
          ),
          Row(
            children: [
              SizedBox(
                width: width / 15,
              ),
              SizedBox(
                width: width - (width / 15),
                child: TextField(
                  controller: _controller1,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: Localization.of(context)
                          .getTranslatedValue("Card Number"),
                      suffixIcon: PopupMenuButton(
                          itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  child: Text("choice 1"),
                                  value: "choice 1",
                                ),
                                PopupMenuItem(
                                  child: Text("choice 2"),
                                  value: "choice 2",
                                )
                              ],
                          onSelected: (value) {
                            _controller1.text = value;
                          },
                          icon: Icon(Icons.arrow_drop_down))),
                ),
              ),
            ],
          ),
          //second field text
          SizedBox(
            height: height / 40,
          ),
          Row(
            children: [
              SizedBox(
                width: width / 15,
              ),
              SizedBox(
                width: width - (width / 15),
                child: TextField(
                  controller: _controller2,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText: Localization.of(context)
                        .getTranslatedValue("Phone Number"),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: height / 40,
          ),
          SubmitButton(() {})
        ],
      ),
    );
  }
}
