import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';

class ResultDiagnoseSC extends StatefulWidget {
  ResultDiagnoseSC({
    required this.commandHealthLevel,
    required this.commandHealthDetail,
  });
  static String nameScreen = "ResultDiagnoseSC";
  final double commandHealthLevel;
  final String? commandHealthDetail;

  @override
  _ResultDiagnoseSCState createState() => _ResultDiagnoseSCState();
}

class _ResultDiagnoseSCState extends State<ResultDiagnoseSC> {
  bool _trackAdviceDiagnoseCard = true;

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
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 15.0),
                              width: 90.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: widget.commandHealthLevel != 0.0 ? Colors.red.shade500 : Colors.blue.shade900,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              alignment: Alignment.center,
                              child: FaIcon(
                                _setIconHealthLevel(),
                                size: 45.0,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                mainUserInterfaceLanguage["name_command_health_level"][widget.commandHealthLevel],
                                style: TextStyle(
                                  color: widget.commandHealthLevel != 0.0 ? Colors.red.shade500 : Colors.blue.shade900,
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
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    width: double.maxFinite,
                                    constraints: BoxConstraints(
                                      maxWidth: 750.0,
                                    ),
                                    child: Column(
                                      children: _setDiagnoseContent(),
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
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Icon(
                        //       Icons.add_circle_outlined,
                        //       size: 20.0,
                        //       color: Colors.green.shade400,
                        //     ),
                        //     SizedBox(
                        //       width: 5.0,
                        //     ),
                        //     Text(
                        //       mainUserInterfaceLanguage["diagnose_history_was_saved"],
                        //       style: TextStyle(
                        //         color: Colors.green.shade400,
                        //         fontSize: 15.0,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: [
                            // Container(
                            //   width: 170.0,
                            //   height: 50.0,
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            //       primary: Colors.white,
                            //       onPrimary: Colors.green.shade400,
                            //       shadowColor: Colors.transparent,
                            //       shape: RoundedRectangleBorder(
                            //         side: BorderSide(color: Colors.green.shade500, width: 1.0),
                            //         borderRadius: BorderRadius.circular(50.0),
                            //       ),
                            //     ),
                            //     child: Text(
                            //       mainUserInterfaceLanguage["see_diagnose_path"],
                            //       style: TextStyle(
                            //         color: Colors.green.shade500,
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //       textAlign: TextAlign.center,
                            //       maxLines: 1,
                            //       overflow: TextOverflow.ellipsis,
                            //     ),
                            //     onPressed: () {},
                            //   ),
                            // ),
                            Container(
                              width: 170.0,
                              height: 50.0,
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
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
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

  Future<Map<String, dynamic>> loadPreferenceAddressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      "province_id": prefs.getString("province_id")!,
      "district_id": prefs.getString("district_id")!,
      "sub_district_id": prefs.getString("sub_district_id")!,
      "zip_code": prefs.getString("zip_code")!,
      "location_permission": prefs.getBool("location_permission")!,
    };
  }

  IconData _setIconHealthLevel() {
    double _healthLevel = widget.commandHealthLevel;
    late IconData _iconResult;

    switch (_healthLevel.toInt()) {
      case 0:
        _iconResult = FontAwesomeIcons.notesMedical;
        break;
      case 1:
        _iconResult = FontAwesomeIcons.hospitalUser;
        break;
      case 2:
        _iconResult = FontAwesomeIcons.hospitalUser;
        break;
      case 3:
        _iconResult = FontAwesomeIcons.hospital;
        break;
      case 4:
        _iconResult = FontAwesomeIcons.ambulance;
        break;
      case 5:
        _iconResult = FontAwesomeIcons.ambulance;
        break;
    }

    return _iconResult;
  }

  List<Widget> _setDiagnoseContent() {
    List<Widget> _widgetResult = [];

    if (widget.commandHealthDetail != null) {
      _widgetResult.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue.shade800.withOpacity(0.5),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          constraints: BoxConstraints(maxWidth: 750.0),
          child: ExpansionTileCard(
            initiallyExpanded: true,
            trailing: Text(
              _trackAdviceDiagnoseCard == false ? mainUserInterfaceLanguage["show"] : mainUserInterfaceLanguage["hide"],
              style: TextStyle(
                color: _trackAdviceDiagnoseCard == false ? Colors.blue.shade800 : Colors.blueGrey.shade800,
              ),
            ),
            finalPadding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(5.0),
            baseColor: Colors.white,
            expandedColor: Colors.white,
            shadowColor: Colors.transparent,
            title: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.commentMedical,
                  size: 18.0,
                  color: Colors.blue.shade800,
                ),
                SizedBox(
                  width: 7.0,
                ),
                Flexible(
                  child: Text(
                    mainUserInterfaceLanguage["header_advice_diagnose"],
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            children: <Widget>[
              Divider(
                height: 1.0,
                indent: 15.0,
                endIndent: 15.0,
                color: Colors.blue.shade800.withOpacity(0.7),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 15.0),
                child: Text(
                  widget.commandHealthDetail ?? "",
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            onExpansionChanged: (val) => setState(
              () {
                _trackAdviceDiagnoseCard = val;
              },
            ),
          ),
        ),
      );
    }

    if (widget.commandHealthLevel > 0.0) {
      _widgetResult.add(
        FutureBuilder(
          future: loadPreferenceAddressData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            VoidCallback? _searchHospitalData;

            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data;
              _searchHospitalData = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchHospitalSC(
                      provinceId: data["province_id"],
                      districtId: data["district_id"],
                      subDistrictId: data["sub_district_id"],
                      zipCode: data["zip_code"],
                      isLocationPermission: data["location_permission"],
                    ),
                  ),
                );
              };
            }

            return Opacity(
              opacity: _searchHospitalData != null ? 1.0 : 0.3,
              child: Container(
                height: 98.0,
                margin: EdgeInsets.symmetric(vertical: 5.0),
                constraints: BoxConstraints(maxWidth: 450.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
                    primary: Colors.red.shade400,
                    onPrimary: Colors.red.shade100,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.red.shade400,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(minHeight: 70.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(14.0),
                              margin: EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.hospitalAlt,
                                size: 34.0,
                                color: Colors.red.shade400,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "${mainUserInterfaceLanguage["menu_find_hospital"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Visibility(
                                    visible: mainUserInterfaceLanguage["sub_menu_find_hospital"] != null,
                                    child: Text(
                                      mainUserInterfaceLanguage["sub_menu_find_hospital"] != null ? mainUserInterfaceLanguage["sub_menu_find_hospital"] : "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onPressed: _searchHospitalData,
                ),
              ),
            );
          },
        ),
      );
    }

    return _widgetResult;
  }
}
