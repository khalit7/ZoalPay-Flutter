import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class HigherEducation extends StatelessWidget {
  static final pageName = "HigherEducation";
  var _controllerTab1Field1 = TextEditingController();
  var _controllerTab1Field2 = TextEditingController();
  var _controllerTab1Field3 = TextEditingController();
  var _controllerTab1Field4 = TextEditingController();
  var _controllerTab1Field5 = TextEditingController();
  var _controllerTab1Field6 = TextEditingController();
  var _controllerTab2Field1 = TextEditingController();
  var _controllerTab2Field2 = TextEditingController();
  var _controllerTab2Field3 = TextEditingController();
  var _controllerTab2Field4 = TextEditingController();
  var _controllerTab2Field5 = TextEditingController();
  var _controllerTab2Field6 = TextEditingController();
  var _controllerTab2Field7 = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Higher Education"),
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
                            .getTranslatedValue("SUDANESE CERTIFICATE"),
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                    Tab(
                        child: Text(
                            Localization.of(context)
                                .getTranslatedValue("ARAB CERTIFICATE"),
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
                                      .getTranslatedValue("Course"),
                                  suffixIcon: PopupMenuButton(
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                              child: Text("Academic"),
                                              value: "Academic",
                                            ),
                                            PopupMenuItem(
                                              child: Text("Agricultural"),
                                              value: "Agricultural",
                                            ),
                                            PopupMenuItem(
                                              child: Text("Commercial"),
                                              value: "Commercial",
                                            ),
                                            PopupMenuItem(
                                              child: Text("Industrial"),
                                              value: "Industrial",
                                            ),
                                            PopupMenuItem(
                                              child: Text("Womanly"),
                                              value: "Womanly",
                                            ),
                                            PopupMenuItem(
                                              child: Text("Ahlia"),
                                              value: "Ahlia",
                                            ),
                                            PopupMenuItem(
                                              child: Text("Readings"),
                                              value: "Readings",
                                            ),
                                          ],
                                      onSelected: (value) {
                                        _controllerTab1Field2.text = value;
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
                              controller: _controllerTab1Field3,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("Form Type"),
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
                                        _controllerTab1Field3.text = value;
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
                              controller: _controllerTab1Field4,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Seat Number"),
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
                              controller: _controllerTab1Field5,
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
                      //sixth field text
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
                              controller: _controllerTab1Field6,
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
                                      .getTranslatedValue("Course"),
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
                                        _controllerTab2Field2.text = value;
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
                              controller: _controllerTab2Field3,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("Form Type"),
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
                                        _controllerTab2Field3.text = value;
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
                              controller: _controllerTab2Field4,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Student Name"),
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
                                    .getTranslatedValue("Phone Number"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //sixth field text
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
                                    .getTranslatedValue("Amount"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //seventh field text
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
                              controller: _controllerTab2Field7,
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
