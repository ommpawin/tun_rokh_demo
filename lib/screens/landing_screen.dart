import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';

class LandingSC extends StatefulWidget {
  LandingSC({
    this.appVersion,
    this.appLanguageId,
    this.appLanguageVersion,
  });
  static String nameScreen = "LandingSC";
  final String? appVersion;
  final String? appLanguageId;
  final String? appLanguageVersion;

  @override
  _LandingSCState createState() => _LandingSCState();
}

class _LandingSCState extends State<LandingSC> {
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/image_background.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 388.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero(
                            tag: "App_Logo",
                            child: Image(
                              image: AssetImage("assets/images/tun_rokh_logo.png"),
                              width: MediaQuery.of(context).size.width * 0.75,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            mainUserInterfaceLanguage["application_language"],
                            style: TextStyle(color: Colors.blue.shade800.withOpacity(1.0), fontSize: 25.0, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200.0,
                    child: SpinKitPumpingHeart(
                      color: Colors.red.shade400,
                      duration: Duration(milliseconds: 500),
                    ),
                  ),
                  Visibility(
                    visible: widget.appVersion != null && widget.appLanguageId != null && widget.appLanguageVersion != null,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Colors.blue.shade800.withOpacity(0.8),
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Application Version : ",
                            ),
                            TextSpan(
                              text: "${widget.appVersion}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "  |  ",
                            ),
                            TextSpan(
                              text: "Language Package : ",
                            ),
                            TextSpan(
                              text: "${widget.appLanguageId} ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "(${widget.appLanguageVersion})",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
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

  void _loadPreferenceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _titleName = prefs.getInt("title_name");
    _firstName = prefs.getString("first_name");
    _lastName = prefs.getString("last_name");
    _provinceId = prefs.getString("province_id");
    _districtId = prefs.getString("district_id");
    _subDistrictId = prefs.getString("sub_district_id");
    _zipCode = prefs.getString("zip_code");
    _isLocationPermission = prefs.getBool("location_permission");

    if (_isLocationPermission == null) {
      _testGeoLocationPermission(false);
    } else if (_isLocationPermission == false) {
      Random r = new Random();
      double falseProbability = .75;
      bool booleanResult = r.nextDouble() > falseProbability;
      if (booleanResult) {
        _testGeoLocationPermission(false);
      } else {
        _testGeoLocationPermission(true);
      }
    } else {
      await Future.delayed(
        const Duration(seconds: 2),
        () {
          if (_titleName == null || _firstName == null || _lastName == null || _provinceId == null || _districtId == null || _subDistrictId == null || _zipCode == null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CreateProfileSC(),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeSC(),
              ),
              (route) => false,
            );
          }
        },
      );
    }
  }

  Future<void> _testGeoLocationPermission(bool passThrough) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _returnValue = false;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        prefs.setBool("location_permission", false);
        if (passThrough) {
          if (_titleName == null || _firstName == null || _lastName == null || _provinceId == null || _districtId == null || _subDistrictId == null || _zipCode == null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CreateProfileSC(),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeSC(),
              ),
              (route) => false,
            );
          }
        } else {
          _noGeoPermissionDialog();
        }
      } else {
        prefs.setBool("location_permission", true);
        if (_titleName == null || _firstName == null || _lastName == null || _provinceId == null || _districtId == null || _subDistrictId == null || _zipCode == null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProfileSC(),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeSC(),
            ),
            (route) => false,
          );
        }
      }
    }
  }

  Future<void> _noGeoPermissionDialog() async {
    showDialog(
      context: context,
      barrierColor: Colors.blue.shade50,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.red.shade600,
            width: 1.0,
          ),
        ),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 60.0, maxWidth: 450.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 18.0,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.error_outline_outlined,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Flexible(
                      child: Text(
                        mainUserInterfaceLanguage["header_no_permission"],
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.0,
                color: Colors.red.shade800.withOpacity(0.7),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      mainUserInterfaceLanguage["no_geo_permission"],
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      mainUserInterfaceLanguage["detail_set_no_geo_permission"].replaceAll("00", mainUserInterfaceLanguage["application_name"]),
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: [
                        Container(
                          width: 142.0,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              primary: Colors.white,
                              onPrimary: Colors.red.shade100,
                              onSurface: Colors.red.shade300,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red.shade500, width: 1.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Text(
                              mainUserInterfaceLanguage["accept"],
                              style: TextStyle(
                                color: Colors.red.shade500,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () {
                              if (_titleName == null || _firstName == null || _lastName == null || _provinceId == null || _districtId == null || _subDistrictId == null || _zipCode == null) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateProfileSC(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeSC(),
                                  ),
                                  (route) => false,
                                );
                              }
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
    );
  }
}
