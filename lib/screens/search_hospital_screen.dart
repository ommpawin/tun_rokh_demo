import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/address.dart';
import 'package:tun_rokh_demo/data/address_language.dart';
import 'package:tun_rokh_demo/data/hospital.dart';
import 'package:tun_rokh_demo/data/hospital_language.dart';

class SearchHospitalSC extends StatefulWidget {
  SearchHospitalSC({
    required this.provinceId,
    required this.districtId,
    required this.subDistrictId,
    required this.zipCode,
    required this.isLocationPermission,
  });
  static String nameScreen = "SearchHospitalSC";
  final String provinceId;
  final String districtId;
  final String subDistrictId;
  final String zipCode;
  final bool isLocationPermission;

  @override
  _SearchHospitalSCState createState() => _SearchHospitalSCState();
}

class _SearchHospitalSCState extends State<SearchHospitalSC> {
  final _addressController = TextEditingController();
  StreamSubscription? _subscription;
  ScrollController _scrollController = ScrollController();
  String? _saveProvinceId;
  String? _saveDistrictId;
  String? _saveSubDistrictId;
  String? _saveZipCode;
  bool _isOnline = false;

  @override
  void initState() {
    _saveProvinceId = widget.provinceId;
    _saveDistrictId = widget.districtId;
    _saveSubDistrictId = widget.subDistrictId;
    _saveZipCode = widget.zipCode;

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }

    _addressController.text = _setAddressDisplay(
      province: _saveProvinceId,
      district: _saveDistrictId,
      subDistrict: _saveSubDistrictId,
      zipCode: _saveZipCode,
    );

    _checkFirstTimeConnectivity();

    _subscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        setState(() {
          if (event == ConnectivityResult.none) {
            _isOnline = false;
          } else {
            _isOnline = true;
          }
        });
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(top: 7.0),
                        child: Text(
                          mainUserInterfaceLanguage["menu_find_hospital"],
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
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 10.0,
                ),
                child: Column(
                  children: <Widget>[
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: _isOnline && widget.isLocationPermission ? 1.0 : 0.3,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        constraints: BoxConstraints(maxWidth: 450.0),
                        child: Container(
                          width: double.maxFinite,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              primary: Colors.green.shade500,
                              onPrimary: Colors.green.shade100,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.green.shade500,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 5.0),
                                  padding: EdgeInsets.all(5.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.satelliteDish,
                                    size: 23.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    mainUserInterfaceLanguage["find_nearby_hospital"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (_isOnline) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchHospitalGeolocationSC(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 14.0, 10.0, 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue.shade600.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        constraints: BoxConstraints(maxWidth: 450.0),
                        child: TextFormField(
                          controller: _addressController,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: Container(
                              width: 48.0,
                              margin: EdgeInsets.only(bottom: 7.0),
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.red.shade500,
                                size: 20.0,
                              ),
                            ),
                            label: Text(
                              mainUserInterfaceLanguage["find_private_address_hospital"],
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            Timer(new Duration(milliseconds: 10), () async {
                              Map<String, dynamic>? _addressResult = await _setAddressDialog();

                              if (_addressResult != null) {
                                _saveProvinceId = _addressResult["provinceId"];
                                _saveDistrictId = _addressResult["districtId"];
                                _saveSubDistrictId = _addressResult["subDistrictId"];
                                _saveZipCode = _addressResult["zipCode"];

                                setState(() {
                                  _addressController.text = _setAddressDisplay(
                                    province: _saveProvinceId,
                                    district: _saveDistrictId,
                                    subDistrict: _saveSubDistrictId,
                                    zipCode: _saveZipCode,
                                  );
                                  _findHospitalIdList();
                                  if (_scrollController.hasClients) {
                                    _scrollController.animateTo(
                                      0.0,
                                      curve: Curves.ease,
                                      duration: Duration(milliseconds: 300),
                                    );
                                  }
                                });
                              }

                              FocusScope.of(context).nextFocus();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  constraints: BoxConstraints(maxWidth: 470.0),
                  child: FutureBuilder(
                    future: _findHospitalIdList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Widget>? _setHospitalListContent(List<int>? hospitalKeyList, String? searchFrom) {
                        List<Widget>? _widgetResult = [];

                        if (hospitalKeyList != null && hospitalKeyList.length > 0) {
                          _widgetResult.add(
                            Container(
                              width: double.maxFinite,
                              constraints: BoxConstraints(maxWidth: 470.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    mainUserInterfaceLanguage["header_hospital"],
                                    style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Text(
                                    "${mainUserInterfaceLanguage["search_range"]} : ${mainUserInterfaceLanguage[searchFrom]} ${hospitalKeyList.length} ${mainUserInterfaceLanguage["list_item"]}",
                                    style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          );

                          hospitalKeyList.forEach(
                            (value) {
                              Map<String, dynamic> _hospitalData = mainHospitalData[value];

                              _widgetResult.add(
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 17.5, right: 16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  constraints: BoxConstraints(maxWidth: 470.0, minHeight: 117.0),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          FaIcon(
                                            FontAwesomeIcons.hospitalAlt,
                                            size: 18.0,
                                            color: Colors.blue.shade800,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  mainUserInterfaceLanguage["hospital_type"][_hospitalData["hospital_type"]],
                                                  style: TextStyle(
                                                    color: Colors.blue.shade800,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  mainHospitalLanguage[_hospitalData["hospital_id"]]["hospital_name"],
                                                  style: TextStyle(
                                                    color: Colors.blue.shade800,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        height: 10.0,
                                        color: Colors.blue.shade800.withOpacity(0.7),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${mainUserInterfaceLanguage["input_address"]} : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: _setAddressDisplay(
                                                    address: mainHospitalLanguage[_hospitalData["hospital_id"]]["hospital_address"],
                                                    province: _hospitalData["hospital_province_code"],
                                                    district: _hospitalData["hospital_districts_code"],
                                                    subDistrict: _hospitalData["hospital_sub_districts_code"],
                                                    zipCode: _hospitalData["hospital_zip_code"],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${mainUserInterfaceLanguage["input_contact"]} : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: mainHospitalLanguage[_hospitalData["hospital_id"]]["hospital_contact"] == null || mainHospitalLanguage[_hospitalData["hospital_id"]]["hospital_contact"] == "-" || mainHospitalLanguage[_hospitalData["hospital_id"]]["hospital_contact"].length < 2 ? "-" : mainHospitalLanguage[_hospitalData["hospital_id"]]["hospital_contact"],
                                                ),
                                              ],
                                            ),
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: _isOnline,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 6.0),
                                          child: Divider(
                                            height: 1.0,
                                            color: Colors.blue.shade800.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        height: _isOnline ? 55.0 : 0,
                                        child: AnimatedOpacity(
                                          duration: Duration(milliseconds: 400),
                                          opacity: _isOnline ? 1.0 : 0,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  child: Container(
                                                    height: 40.0,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                        primary: Colors.white,
                                                        onPrimary: Colors.green.shade100,
                                                        shadowColor: Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color: Colors.green.shade500,
                                                          ),
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            margin: EdgeInsets.only(right: 5.0),
                                                            padding: EdgeInsets.all(5.0),
                                                            child: FaIcon(
                                                              FontAwesomeIcons.mapMarkedAlt,
                                                              size: 22.0,
                                                              color: Colors.green.shade500,
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "${mainUserInterfaceLanguage["show_location_on"]} ${mainUserInterfaceLanguage["google_maps"]}",
                                                              style: TextStyle(
                                                                color: Colors.green.shade500,
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () async {
                                                        if (_isOnline) {
                                                          String _url = _hospitalData["hospital_location_url"];
                                                          var _launchResult = await canLaunch(_url);

                                                          if (_launchResult) {
                                                            await launch(
                                                              _url,
                                                              forceSafariVC: true,
                                                              enableJavaScript: true,
                                                            );
                                                          }
                                                        }
                                                      },
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
                              );
                            },
                          );
                        }

                        return _widgetResult;
                      }

                      Widget _widgetResult = Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SpinKitRipple(
                              color: Colors.blue.shade900.withOpacity(0.2),
                              duration: Duration(milliseconds: 2000),
                              size: 250.0,
                            ),
                            Positioned(
                              child: Text(
                                "${mainUserInterfaceLanguage["searching"]}...",
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      );

                      if (snapshot.hasData) {
                        if (snapshot.data!["hospitalKeyList"].length > 0) {
                          List<int>? _hospitalKeyList = snapshot.data!["hospitalKeyList"];
                          String? _searchFrom = snapshot.data!["searchFrom"];

                          _widgetResult = Container(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                      controller: _scrollController,
                                      child: SingleChildScrollView(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        controller: _scrollController,
                                        physics: BouncingScrollPhysics(),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                                          width: double.maxFinite,
                                          constraints: BoxConstraints(
                                            maxWidth: 470.0,
                                          ),
                                          child: Column(
                                            children: _setHospitalListContent(_hospitalKeyList, _searchFrom)!,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          _widgetResult = Container(
                            constraints: BoxConstraints(maxWidth: 470.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    "${mainUserInterfaceLanguage["no_hospital_on_address"]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    "${mainUserInterfaceLanguage["detail_no_hospital_on_address"]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      return _widgetResult;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkFirstTimeConnectivity() async {
    var _result = await Connectivity().checkConnectivity();

    setState(() {
      if (_result == ConnectivityResult.none) {
        _isOnline = false;
      } else {
        _isOnline = true;
      }
    });
  }

  String _setAddressDisplay({String? province, String? district, String? subDistrict, String? address, String? zipCode}) {
    String _resultAddressDisplay = "";

    if (address != null) {
      _resultAddressDisplay += "$address ";
    }

    if (subDistrict != null) {
      _resultAddressDisplay += "${mainAddressLanguage["sub_districts_name"][subDistrict]} ";
    }

    if (district != null) {
      _resultAddressDisplay += "${mainUserInterfaceLanguage["district"]}${mainAddressLanguage["districts_name"][district]} ";
    }

    if (province != null) {
      _resultAddressDisplay += "${mainUserInterfaceLanguage["province"]}${mainAddressLanguage["province_name"][province]} ";
    }

    if (zipCode != null) {
      _resultAddressDisplay += "($zipCode)";
    }

    return _resultAddressDisplay;
  }

  Future<Map<String, dynamic>> _findHospitalIdList() async {
    Map<String, dynamic> _result = {
      "hospitalKeyList": [],
      "searchFrom": "",
    };
    List<int>? _hospitalKeyList = [];
    String? _searchFrom;

    mainHospitalData.asMap().forEach(
      (key, value) {
        String? _subDistrictsCode = value["hospital_sub_districts_code"];

        if (_subDistrictsCode == _saveSubDistrictId) {
          _hospitalKeyList.add(key);

          if (_searchFrom == null) _searchFrom = "sub_district";
        }
      },
    );

    if (_hospitalKeyList.length == 0) {
      mainHospitalData.asMap().forEach(
        (key, value) {
          String? _districtsCode = value["hospital_districts_code"];

          if (_districtsCode == _saveDistrictId) {
            _hospitalKeyList.add(key);

            if (_searchFrom == null) _searchFrom = "district";
          }
        },
      );
    }

    if (_hospitalKeyList.length == 0) {
      mainHospitalData.asMap().forEach(
        (key, value) {
          String? _provinceCode = value["hospital_province_code"];

          if (_provinceCode == _saveProvinceId) {
            _hospitalKeyList.add(key);

            if (_searchFrom == null) _searchFrom = "province";
          }
        },
      );
    }

    if (_hospitalKeyList.length != 0 && _searchFrom != null) {
      _result["hospitalKeyList"] = _hospitalKeyList;
      _result["searchFrom"] = _searchFrom;
    }

    return _result;
  }

  Future<Map<String, dynamic>?> _setAddressDialog() async {
    Map<String, dynamic>? _result;
    int _frameSelection = 0;
    bool _nextCondition = false;
    String? _province;
    String? _district;
    String? _subDistrict;
    String? _zipCode;
    int _provinceIndex = 0;
    int _districtIndex = 0;
    int _subDistrictIndex = 0;
    String _addressDisplayValue = "";

    await showDialog(
      context: context,
      barrierColor: Colors.blue.shade50,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            Container _setAddressSelectionButton({
              required String title,
              bool isSelect = false,
              required VoidCallback onPressed,
            }) {
              return Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(vertical: 2.5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
                    primary: isSelect == true ? Colors.blue.shade600 : Colors.white,
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
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isSelect == true ? Colors.white : Colors.blue.shade600,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  onPressed: onPressed,
                ),
              );
            }

            List<Container> _frameSelect = [
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${mainUserInterfaceLanguage["province"]}",
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Text(
                            "${mainAddressData.length} ${mainUserInterfaceLanguage["list_item"]}",
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
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
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Column(
                              children: List.generate(
                                mainAddressData.length,
                                (index) {
                                  Map<String, dynamic> _data = mainAddressData[index];
                                  return _setAddressSelectionButton(
                                    title: mainAddressLanguage["province_name"][_data["province_code"]],
                                    isSelect: _province == _data["province_code"],
                                    onPressed: () {
                                      setState(() {
                                        _province = _data["province_code"];
                                        _provinceIndex = index;
                                        _nextCondition = true;
                                        _addressDisplayValue = _setAddressDisplay(
                                          province: _province,
                                          district: _district,
                                          subDistrict: _subDistrict,
                                          zipCode: _zipCode,
                                        );
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            mainUserInterfaceLanguage["district"],
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Text(
                            "${mainAddressData[_provinceIndex]["district"].length} ${mainUserInterfaceLanguage["list_item"]}",
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
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
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Column(
                              children: List.generate(
                                mainAddressData[_provinceIndex]["district"].length,
                                (index) {
                                  Map<String, dynamic> _data = mainAddressData[_provinceIndex]["district"][index];
                                  return _setAddressSelectionButton(
                                    title: mainAddressLanguage["districts_name"][_data["district_code"]],
                                    isSelect: _district == _data["district_code"],
                                    onPressed: () {
                                      setState(() {
                                        _district = _data["district_code"];
                                        _districtIndex = index;
                                        _nextCondition = true;
                                        _addressDisplayValue = _setAddressDisplay(
                                          province: _province,
                                          district: _district,
                                          subDistrict: _subDistrict,
                                          zipCode: _zipCode,
                                        );
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            mainUserInterfaceLanguage["sub_district"],
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Text(
                            "${mainAddressData[_provinceIndex]["district"][_districtIndex]["sub_districr"].length} ${mainUserInterfaceLanguage["list_item"]}",
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
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
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Column(
                              children: List.generate(
                                mainAddressData[_provinceIndex]["district"][_districtIndex]["sub_districr"].length,
                                (index) {
                                  Map<String, dynamic> _data = mainAddressData[_provinceIndex]["district"][_districtIndex]["sub_districr"][index];
                                  return _setAddressSelectionButton(
                                    title: mainAddressLanguage["sub_districts_name"][_data["sub_district_code"]],
                                    isSelect: _subDistrict == _data["sub_district_code"],
                                    onPressed: () {
                                      setState(() {
                                        _subDistrict = _data["sub_district_code"];
                                        _zipCode = _data["zip_code"];
                                        _subDistrictIndex = index;
                                        _nextCondition = true;
                                        _addressDisplayValue = _setAddressDisplay(
                                          province: _province,
                                          district: _district,
                                          subDistrict: _subDistrict,
                                          zipCode: _zipCode,
                                        );
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.blue.shade600,
                  width: 1.0,
                ),
              ),
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                            Text(
                              mainUserInterfaceLanguage["find_private_address_hospital"],
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: Colors.blue.shade800.withOpacity(0.7),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 82.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Text(
                          _addressDisplayValue == "" ? mainUserInterfaceLanguage["please_select_address"] : _addressDisplayValue,
                          style: TextStyle(
                            color: _addressDisplayValue == "" ? Colors.blue.shade800.withOpacity(0.5) : Colors.blue.shade800,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: Colors.blue.shade800.withOpacity(0.7),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 350.0,
                        child: _frameSelect[_frameSelection],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 10.0,
                          children: <Widget>[
                            Visibility(
                              visible: _frameSelection == 0,
                              child: Container(
                                width: 142.0,
                                height: 50.0,
                                margin: EdgeInsets.only(right: 5.0),
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
                                    mainUserInterfaceLanguage["cancel"],
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
                                    _result = null;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _frameSelection > 0,
                              child: Container(
                                width: 142.0,
                                height: 50.0,
                                margin: EdgeInsets.only(right: 5.0),
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
                                    mainUserInterfaceLanguage["back"],
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
                                    if (_frameSelection == 1) {
                                      _province = null;
                                      _provinceIndex = 0;
                                      _district = null;
                                      _districtIndex = 0;
                                    } else if (_frameSelection == 2) {
                                      _district = null;
                                      _districtIndex = 0;
                                      _subDistrict = null;
                                      _zipCode = null;
                                      _subDistrictIndex = 0;
                                    }
                                    _nextCondition = false;
                                    _addressDisplayValue = _setAddressDisplay(
                                      province: _province,
                                      district: _district,
                                      subDistrict: _subDistrict,
                                      zipCode: _zipCode,
                                    );
                                    setState(() {
                                      _frameSelection--;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _frameSelection < _frameSelect.length - 1,
                              child: Container(
                                width: 142.0,
                                height: 50.0,
                                margin: EdgeInsets.only(left: 5.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                    primary: _nextCondition == true ? Colors.green.shade500 : Colors.white,
                                    onPrimary: Colors.green.shade100,
                                    onSurface: Colors.green.shade300,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.green.shade500, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  child: Text(
                                    mainUserInterfaceLanguage["next"],
                                    style: TextStyle(
                                      color: _nextCondition == true ? Colors.white : Colors.green.shade500,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onPressed: () {
                                    if (_nextCondition == true) {
                                      _nextCondition = false;
                                      setState(() {
                                        _frameSelection++;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _frameSelection == _frameSelect.length - 1,
                              child: Container(
                                width: 142.0,
                                height: 50.0,
                                margin: EdgeInsets.only(left: 5.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                    primary: _nextCondition == true ? Colors.green.shade500 : Colors.white,
                                    onPrimary: Colors.green.shade100,
                                    onSurface: Colors.green.shade300,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.green.shade500, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  child: Text(
                                    mainUserInterfaceLanguage["search_answer"],
                                    style: TextStyle(
                                      color: _nextCondition == true ? Colors.white : Colors.green.shade500,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onPressed: () {
                                    if (_province != null && _district != null && _subDistrict != null && _zipCode != null) {
                                      _result = {
                                        "provinceId": _province,
                                        "districtId": _district,
                                        "subDistrictId": _subDistrict,
                                        "zipCode": _zipCode,
                                      };
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    return _result;
  }
}
