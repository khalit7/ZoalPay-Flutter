import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class Customs extends StatelessWidget {
  static final pageName = "Customs";
  var _controllerTab2Field1 = TextEditingController();
  var _controllerTab2Field2 = TextEditingController();
  var _controllerTab2Field3 = TextEditingController();
  var _controllerTab2Field4 = TextEditingController();
  var _controllerTab2Field5 = TextEditingController();
  var _controllerTab2Field6 = TextEditingController();
  var _controllerTab1Field1 = TextEditingController();
  var _controllerTab1Field2 = TextEditingController();
  var _controllerTab1Field3 = TextEditingController();
  var _controllerTab1Field4 = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("CUSTOMS"),
        ),
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height / 15,
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        Localization.of(context)
                            .getTranslatedValue("CUSTOMS INQUIRY"),
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Tab(
                        child: Text(
                            Localization.of(context)
                                .getTranslatedValue("CUSTOMS"),
                            style: TextStyle(color: Colors.red)))
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  //first tab
                  ListView(
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
                              controller: _controllerTab1Field1,
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
                                        _controllerTab1Field1.text = value;
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
                              controller: _controllerTab1Field2,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Bank Code"),
                              ),
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
                              controller: _controllerTab1Field3,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Declarant"),
                              ),
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
                              controller: _controllerTab1Field4,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("IPIN"),
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
                  //second tab
                  ListView(
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
                              controller: _controllerTab2Field1,
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
                                        _controllerTab2Field1.text = value;
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
                              controller: _controllerTab2Field2,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Bank Code"),
                              ),
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
                              controller: _controllerTab2Field3,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Declarant"),
                              ),
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
                              controller: _controllerTab2Field4,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Amount"),
                              ),
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
                              controller: _controllerTab2Field5,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Comment"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //sixth field
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
                              controller: _controllerTab2Field6,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("IPIN"),
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
                ]),
              )
            ],
          )),
    );
  }
}
