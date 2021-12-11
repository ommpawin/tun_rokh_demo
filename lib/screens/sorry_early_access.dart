import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';

class SorryEarlyAccessSC extends StatefulWidget {
  static String nameScreen = "SorryEarlyAccessSC";

  @override
  _SorryEarlyAccessSCState createState() => _SorryEarlyAccessSCState();
}

class _SorryEarlyAccessSCState extends State<SorryEarlyAccessSC> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, valProvi, child) => WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeSC()),
            (route) => false,
          );

          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.blue.shade50,
          body: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                mainUserInterfaceLanguage["header_sorry_early_access"],
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ShaderMask(
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.blue.shade50, Colors.transparent, Colors.transparent, Colors.blue.shade50],
                            stops: [0.0, 0.015, 0.99, 1.5], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.red.shade500.withOpacity(0.8),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                constraints: BoxConstraints(maxWidth: 400.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      height: 35.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          FaIcon(
                                            FontAwesomeIcons.pencilRuler,
                                            size: 18.0,
                                            color: Colors.red.shade500,
                                          ),
                                          SizedBox(
                                            width: 7.0,
                                          ),
                                          Flexible(
                                            child: Text(
                                              mainUserInterfaceLanguage["title_sorry_early_access"],
                                              style: TextStyle(
                                                color: Colors.red.shade500,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 20.0,
                                      indent: 15.0,
                                      endIndent: 15.0,
                                      color: Colors.red.shade800.withOpacity(0.7),
                                    ),
                                    Text(
                                      mainUserInterfaceLanguage["content_sorry_early_access"],
                                      style: TextStyle(
                                        color: Colors.red.shade800,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: [
                            Container(
                              width: 170.0,
                              height: 60.0,
                              margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                  primary: Colors.green.shade500,
                                  onPrimary: Colors.green.shade100,
                                  onSurface: Colors.green.shade300,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.green.shade500, width: 1.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                child: Text(
                                  mainUserInterfaceLanguage["accept"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeSC()),
                                    (route) => false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
