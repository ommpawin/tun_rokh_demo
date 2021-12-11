import 'package:flutter/material.dart';

class UserInterfaceStandardSC extends StatefulWidget {
  UserInterfaceStandardSC({Key? key}) : super(key: key);
  static String nameScreen = "UserInterfaceStandardSC";

  @override
  _UserInterfaceStandardSCState createState() => _UserInterfaceStandardSCState();
}

class _UserInterfaceStandardSCState extends State<UserInterfaceStandardSC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Header Danger",
                    style: TextStyle(
                      color: Colors.red.shade500,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 15.0),
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(color: Colors.red.shade500, borderRadius: BorderRadius.circular(100.0)),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.info,
                          size: 45.0,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Header Danger",
                          style: TextStyle(
                            color: Colors.red.shade500,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Header Main 1",
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 5.0, right: 10.0),
                            primary: Colors.red.shade200.withOpacity(0.15),
                            onPrimary: Colors.red.shade200,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: Icon(
                            Icons.info,
                            color: Colors.red,
                          ),
                          label: Text(
                            "Return Button",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Header Main 1",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Header Main 2",
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
