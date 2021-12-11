import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/address.dart';
import 'package:tun_rokh_demo/data/address_language.dart';

class EditProfileSC extends StatefulWidget {
  EditProfileSC({
    required this.titleName,
    required this.firstName,
    required this.lastName,
    required this.provinceId,
    required this.districtId,
    required this.subDistrictId,
    required this.zipCode,
  });

  static String nameScreen = "EditProfileSC";
  final int titleName;
  final String firstName;
  final String lastName;
  final String provinceId;
  final String districtId;
  final String subDistrictId;
  final String zipCode;

  @override
  _EditProfileSCState createState() => _EditProfileSCState();
}

class _EditProfileSCState extends State<EditProfileSC> {
  final _titleNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  int? _saveTitleName;
  String? _saveProvinceId;
  String? _saveDistrictId;
  String? _saveSubDistrictId;
  String? _saveZipCode;

  bool _saveCondition = false;

  @override
  void initState() {
    _saveTitleName = widget.titleName;
    _saveProvinceId = widget.provinceId;
    _saveDistrictId = widget.districtId;
    _saveSubDistrictId = widget.subDistrictId;
    _saveZipCode = widget.zipCode;

    _titleNameController.text = mainUserInterfaceLanguage["title_name_list"][widget.titleName];
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _addressController.text = _setAddressDisplay(
      province: _saveProvinceId,
      district: _saveDistrictId,
      subDistrict: _saveSubDistrictId,
      zipCode: _saveZipCode,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                            mainUserInterfaceLanguage["header_edit_profile"],
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
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          constraints: BoxConstraints(maxWidth: 550.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue.shade600.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextFormField(
                                  controller: _titleNameController,
                                  readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    label: Text(
                                      mainUserInterfaceLanguage["input_title_name"],
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  cursorColor: Colors.blue.shade700,
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  onTap: () async {
                                    int? _titleNameResult = await _setTitleNameDialog();
                
                                    if (_titleNameResult != null) {
                                      _saveTitleName = _titleNameResult;
                
                                      setState(() {
                                        _titleNameController.text = mainUserInterfaceLanguage["title_name_list"][_saveTitleName];
                                      });
                
                                      FocusScope.of(context).nextFocus();
                                    } else {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _setSaveCondition();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue.shade600.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextFormField(
                                  controller: _firstNameController,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    label: Text(
                                      mainUserInterfaceLanguage["input_first_name"],
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  cursorColor: Colors.blue.shade700,
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _setSaveCondition();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue.shade600.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    label: Text(
                                      mainUserInterfaceLanguage["input_last_name"],
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  cursorColor: Colors.blue.shade700,
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _setSaveCondition();
                                    });
                                  },
                                  onFieldSubmitted: (value) async {
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
                                        });
                                      }
                
                                      FocusScope.of(context).nextFocus();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
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
                                        mainUserInterfaceLanguage["input_address"],
                                        style: TextStyle(
                                          color: Colors.blue.shade600,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                                          });
                                        }
                
                                        FocusScope.of(context).nextFocus();
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _setSaveCondition();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
                                child: Wrap(
                                  spacing: 10.0,
                                  runSpacing: 10.0,
                                  children: <Widget>[
                                    Container(
                                      width: 160.0,
                                      height: 50.0,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          primary: Colors.red.shade500,
                                          onPrimary: Colors.red.shade100,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Colors.red.shade500,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(60.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 5.0),
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.remove_circle,
                                                size: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                mainUserInterfaceLanguage["delete"],
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
                                          _dialogDeleteProfile();
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 165.0,
                                      height: 50.0,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          primary: _saveCondition ? Colors.green.shade500 : Colors.white.withOpacity(0.7),
                                          onPrimary: _saveCondition ? Colors.green.shade100 : Colors.grey.shade200,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: _saveCondition ? Colors.green.shade500 : Colors.green.shade300, width: 1.0),
                                            borderRadius: BorderRadius.circular(60.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 5.0),
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                _saveCondition ? Icons.add_circle_outlined : Icons.add_circle_outline_outlined,
                                                size: 25.0,
                                                color: _saveCondition ? Colors.white : Colors.green.shade300,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                mainUserInterfaceLanguage["save_answer"],
                                                style: TextStyle(
                                                  color: _saveCondition ? Colors.white : Colors.green.shade300,
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
                                        onPressed: () async {
                                          if (_saveCondition) {
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            await prefs.setInt("title_name", _saveTitleName!);
                                            await prefs.setString("first_name", _firstNameController.text.trim());
                                            await prefs.setString("last_name", _lastNameController.text.trim());
                                            await prefs.setString("province_id", _saveProvinceId!);
                                            await prefs.setString("district_id", _saveDistrictId!);
                                            await prefs.setString("sub_district_id", _saveSubDistrictId!);
                                            await prefs.setString("zip_code", _saveZipCode!);
                                            await Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LandingSC(),
                                              ),
                                              (route) => false,
                                            );
                                          }
                                        },
                                      ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setSaveCondition() {
    if (_titleNameController.text != "" && _firstNameController.text != "" && _firstNameController.text.length > 2 && _lastNameController.text != "" && _lastNameController.text.length > 2 && _addressController.text != "" && _addressController.text.length > 2) {
      _saveCondition = true;
    } else {
      _saveCondition = false;
    }
  }

  String _setAddressDisplay({String? province, String? district, String? subDistrict, String? zipCode}) {
    String _resultAddressDisplay = "";

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

  Future<int?> _setTitleNameDialog() async {
    int? _result;
    int? _titleNameIndex;

    await showDialog(
      context: context,
      barrierColor: Colors.blue.shade50,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            Container _setTitleNameSelectionButton({
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
                              mainUserInterfaceLanguage["input_title_name"],
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
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 250.0,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "${mainUserInterfaceLanguage["title_name_list"].length} ${mainUserInterfaceLanguage["list_item"]}",
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
                                          mainUserInterfaceLanguage["title_name_list"].length,
                                          (index) {
                                            return _setTitleNameSelectionButton(
                                              title: mainUserInterfaceLanguage["title_name_list"][index],
                                              isSelect: _titleNameIndex == index,
                                              onPressed: () {
                                                setState(() {
                                                  _titleNameIndex = index;
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
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: <Widget>[
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
                            Container(
                              width: 142.0,
                              height: 50.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                  primary: _titleNameIndex != null ? Colors.green.shade500 : Colors.white,
                                  onPrimary: Colors.green.shade100,
                                  onSurface: Colors.green.shade300,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.green.shade500, width: 1.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                child: Text(
                                  mainUserInterfaceLanguage["save_answer"],
                                  style: TextStyle(
                                    color: _titleNameIndex != null ? Colors.white : Colors.green.shade500,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () {
                                  if (_titleNameIndex != null) {
                                    _result = _titleNameIndex;
                                    Navigator.of(context).pop();
                                    _setSaveCondition();
                                  }
                                },
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
                                    title:mainAddressLanguage["province_name"][_data["province_code"]],
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
                              mainUserInterfaceLanguage["input_address"],
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
                                    _setSaveCondition();
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
                                    mainUserInterfaceLanguage["save_answer"],
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
                                      _setSaveCondition();
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

  void _dialogDeleteProfile() {
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
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Flexible(
                      child: Text(
                        mainUserInterfaceLanguage["header_delete_profile"],
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
                      mainUserInterfaceLanguage["delete_profile_warning"],
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
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          width: 142.0,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              primary: Colors.red.shade500,
                              onPrimary: Colors.red.shade100,
                              onSurface: Colors.red.shade300,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red.shade500, width: 1.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Text(
                              mainUserInterfaceLanguage["delete"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.remove("title_name");
                              await prefs.remove("first_name");
                              await prefs.remove("last_name");
                              await prefs.remove("province_id");
                              await prefs.remove("district_id");
                              await prefs.remove("sub_district_id");
                              await prefs.remove("zip_code");
                              await prefs.remove("location_permission");
                              await Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LandingSC(),
                                ),
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
    );
  }
}
