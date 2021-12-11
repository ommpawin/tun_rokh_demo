import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:tun_rokh_demo/model/current_question_store.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/address_language.dart';

class HomeSC extends StatefulWidget {
  static String nameScreen = "HomeSC";

  @override
  _HomeSCState createState() => _HomeSCState();
}

class _HomeSCState extends State<HomeSC> {
  int? _titleName;
  String? _firstName;
  String? _lastName;
  String? _provinceId;
  String? _districtId;
  String? _subDistrictId;
  String? _zipCode;
  bool? _isLocationPermission;

  @override
  void initState() {
    _loadPreferenceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 80.0 + 50.0,
                        alignment: Alignment.centerLeft,
                        child: Hero(
                          tag: "App_Logo",
                          child: Image(
                            image: AssetImage("assets/images/tun_rokh_logo.png"),
                            height: 33.0,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      // ElevatedButton.icon(
                      //     style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.only(left: 5.0, right: 10.0),
                      //       primary: Colors.blue.shade200.withOpacity(0.15),
                      //       onPrimary: Colors.blue.shade200,
                      //       shadowColor: Colors.transparent,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30.0),
                      //       ),
                      //     ),
                      //     icon: Icon(
                      //       Icons.west,
                      //       color: Colors.blue,
                      //     ),
                      //     label: Text(
                      //       mainUserInterfaceLanguage["back"],
                      //       style: TextStyle(
                      //         color: Colors.blue,
                      //         fontSize: 22.0,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       textAlign: TextAlign.start,
                      //       overflow: TextOverflow.ellipsis,
                      //       maxLines: 1,
                      //     ),
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //   ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _loadNotiData(),
                  builder: (context, snapshot) {
                    Widget _resultWidet = SizedBox();
    
                    if (snapshot.hasData) {
                      _resultWidet = AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 3.0),
                        height: snapshot.data == true ? 0 : 60.0,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100.withOpacity(1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        constraints: BoxConstraints(maxWidth: 750),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                          opacity: snapshot.data == true ? 0 : 1.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                padding: EdgeInsets.zero,
                                child: FaIcon(
                                  FontAwesomeIcons.satelliteDish,
                                  size: 18.0,
                                  color: Colors.red.shade400,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  mainUserInterfaceLanguage["noti_no_geo_permission"],
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
    
                    return _resultWidet;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: double.maxFinite,
                    height: 94.0,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    constraints: BoxConstraints(minHeight: 80.0, maxWidth: 550.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 10.0),
                        primary: Colors.white,
                        onPrimary: Colors.blue.shade50,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.blue.shade300.withOpacity(0.6),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FutureBuilder(
                              future: _loadPreferenceData(),
                              builder: (context, snapshot) {
                                String _name_profile = "";
                                String _address_profile = mainUserInterfaceLanguage["load_profile_data"];
    
                                if (snapshot.hasData) {
                                  Map<String, String> _data = snapshot.data as Map<String, String>;
                                  _name_profile = _data["name_profile"]!;
                                  _address_profile = _data["address_profile"]!;
                                }
    
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _name_profile,
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      _address_profile,
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade300.withOpacity(0.2),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.userAlt,
                              size: 25.0,
                              color: Colors.blue.shade300.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileSC(
                              titleName: _titleName!,
                              firstName: _firstName!,
                              lastName: _lastName!,
                              provinceId: _provinceId!,
                              districtId: _districtId!,
                              subDistrictId: _subDistrictId!,
                              zipCode: _zipCode!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Container(
                                height: 98.0,
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                constraints: BoxConstraints(maxWidth: 450.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
                                    primary: Colors.blue.shade600,
                                    onPrimary: Colors.blue.shade100,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.blue.shade600,
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
                                                FontAwesomeIcons.userMd,
                                                size: 34.0,
                                                color: Colors.blue.shade600,
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    "${mainUserInterfaceLanguage["menu_start_disease"]}",
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
                                                    visible: mainUserInterfaceLanguage["sub_menu_start_disease"] != null,
                                                    child: Text(
                                                      mainUserInterfaceLanguage["sub_menu_start_disease"] != null ? mainUserInterfaceLanguage["sub_menu_start_disease"] : "",
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectDiagnoseGroupSC(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchHospitalSC(
                                          provinceId: _provinceId!,
                                          districtId: _districtId!,
                                          subDistrictId: _subDistrictId!,
                                          zipCode: _zipCode!,
                                          isLocationPermission: _isLocationPermission!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 8.0),
                              //   child: Container(
                              //     width: 450.0,
                              //     child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.stretch,
                              //       children: <Widget>[
                              //         Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: <Widget>[
                              //             Flexible(
                              //               child: Text(
                              //                 mainUserInterfaceLanguage["header_history_diagnose"],
                              //                 style: TextStyle(
                              //                   color: Colors.blue.shade900,
                              //                   fontSize: 22.0,
                              //                   fontWeight: FontWeight.w600,
                              //                 ),
                              //                 textAlign: TextAlign.start,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 maxLines: 1,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         Container(
                              //           child: Text(
                              //             "0/5 ${mainUserInterfaceLanguage["list_item"]}",
                              //             style: TextStyle(
                              //               color: Colors.blue.shade900,
                              //               fontSize: 15.0,
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //             textAlign: TextAlign.start,
                              //             overflow: TextOverflow.ellipsis,
                              //             maxLines: 3,
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           height: 10.0,
                              //         ),
                              //         Container(
                              //           height: 250.0,
                              //           margin: EdgeInsets.symmetric(vertical: 5.0),
                              //           decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.circular(10.0),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
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
      ),
    );
  }

  Future<Map<String, String>> _loadPreferenceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _titleName = prefs.getInt("title_name")!;
    _firstName = prefs.getString("first_name")!;
    _lastName = prefs.getString("last_name")!;
    _provinceId = prefs.getString("province_id")!;
    _districtId = prefs.getString("district_id")!;
    _subDistrictId = prefs.getString("sub_district_id")!;
    _zipCode = prefs.getString("zip_code")!;

    return {
      "name_profile": "${mainUserInterfaceLanguage["title_name_list"][_titleName]}$_firstName $_lastName",
      "address_profile": "${mainAddressLanguage["sub_districts_name"][_subDistrictId]} ${mainUserInterfaceLanguage["district"]}${mainAddressLanguage["districts_name"][_districtId]} ${mainUserInterfaceLanguage["province"]}${mainAddressLanguage["province_name"][_provinceId]} ($_zipCode)",
    };
  }

  Future<bool> _loadNotiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _isLocationPermission = prefs.getBool("location_permission")!;
    return _isLocationPermission = prefs.getBool("location_permission")!;
  }
}
