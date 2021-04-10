import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class ZoalKhairPage extends StatelessWidget {
  static final pageName = "ZoalKhairPage";
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();
  var _controller4 = TextEditingController();
  var _controller5 = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            Localization.of(context).getTranslatedValue("Zoal Khair"),
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
                    onChanged: (string) {},
                    onSubmitted: (string) {},
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
                            .getTranslatedValue("Reference"),
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
                              _controller2.text = value;
                            },
                            icon: Icon(Icons.arrow_drop_down))),
                  ),
                ),
              ],
            ),
            //third field text
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
                    controller: _controller3,
                    onChanged: (string) {},
                    onSubmitted: (string) {},
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                        labelText: Localization.of(context)
                            .getTranslatedValue("Amount"),
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
                              _controller3.text = value;
                            },
                            icon: Icon(Icons.arrow_drop_down))),
                  ),
                ),
              ],
            ),
            //fourth field text
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
                    controller: _controller4,
                    onChanged: (string) {},
                    onSubmitted: (string) {},
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                        labelText: Localization.of(context)
                            .getTranslatedValue("Comment"),
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
                              _controller4.text = value;
                            },
                            icon: Icon(Icons.arrow_drop_down))),
                  ),
                ),
              ],
            ),
            //fifth field text
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
                    controller: _controller5,
                    onChanged: (string) {},
                    onSubmitted: (string) {},
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                        labelText:
                            Localization.of(context).getTranslatedValue("IPIN"),
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
                              _controller5.text = value;
                            },
                            icon: Icon(Icons.arrow_drop_down))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 40,
            ),
            SubmitButton(() {})
          ],
        ));
  }
}
