import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/disease_language.dart';

class DiseaseDetailSC extends StatefulWidget {
  DiseaseDetailSC({required this.diseaseId, required this.diseaseName});
  static String nameScreen = "DiseaseDetailSC";
  final String diseaseId;
  final String diseaseName;

  @override
  _DiseaseDetailSCState createState() => _DiseaseDetailSCState();
}

class _DiseaseDetailSCState extends State<DiseaseDetailSC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton.icon(
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
                        Icons.west,
                        color: Colors.red,
                      ),
                      label: Text(
                        mainUserInterfaceLanguage["back"],
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: <Widget>[
                      Flexible(
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
                              padding: EdgeInsets.only(bottom: 10.0),
                              physics: BouncingScrollPhysics(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                width: double.maxFinite,
                                constraints: BoxConstraints(
                                  maxWidth: 750.0,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  children: _setDiseaseContent(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _setDiseaseContent() {
    List<Widget> _widgetResult = [];

    String? _diseaseDetail = mainDiseaseLanguage[widget.diseaseId]["diseaseDetail"];

    if (_diseaseDetail != null) {
      _widgetResult.add(
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          width: double.maxFinite,
          child: Text(
            widget.diseaseName,
            style: TextStyle(
              color: Colors.blue.shade800,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

      _widgetResult.add(
        Container(
          width: double.maxFinite,
          child: Text(
            _diseaseDetail,
            style: TextStyle(
              color: Colors.blue.shade800,
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      );
    }

    return _widgetResult;
  }
}
