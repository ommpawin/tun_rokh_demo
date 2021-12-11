import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tun_rokh_demo/model/current_question_store.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';

class SelectDiagnoseGroupSC extends StatefulWidget {
  static String nameScreen = "SelectDiagnoseSC";

  @override
  _SelectDiagnoseGroupSCState createState() => _SelectDiagnoseGroupSCState();
}

class _SelectDiagnoseGroupSCState extends State<SelectDiagnoseGroupSC> {
  int _controllerSelectFrame = 0;
  List<Container> _buttonDiagnoseGroup = [];

  @override
  void initState() {
    _buttonDiagnoseGroup = [
      _buttonDiagnoseGroupSelect(
        0,
        mainUserInterfaceLanguage["disease_group_list"][0]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][0]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        1,
        mainUserInterfaceLanguage["disease_group_list"][1]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][1]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        2,
        mainUserInterfaceLanguage["disease_group_list"][2]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][2]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        3,
        mainUserInterfaceLanguage["disease_group_list"][3]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][3]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        4,
        mainUserInterfaceLanguage["disease_group_list"][4]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][4]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        10,
        mainUserInterfaceLanguage["disease_group_list"][10]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][10]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        5,
        mainUserInterfaceLanguage["disease_group_list"][5]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][5]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        6,
        mainUserInterfaceLanguage["disease_group_list"][6]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][6]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        7,
        mainUserInterfaceLanguage["disease_group_list"][7]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][7]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        8,
        mainUserInterfaceLanguage["disease_group_list"][8]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][8]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        9,
        mainUserInterfaceLanguage["disease_group_list"][9]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][9]["disease_group_id"],
        isBold: true,
      ),
      _buttonDiagnoseGroupSelect(
        10,
        mainUserInterfaceLanguage["disease_group_list"][10]["name_disease_group"],
        mainUserInterfaceLanguage["disease_group_list"][10]["disease_group_id"],
        isBold: true,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentQuestionStore>(
      builder: (context, valProvi, child) {
        if (valProvi.diagnoseTimeline.length > 0) {
          valProvi.clearCurrentWidget(true);
        }

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
                              mainUserInterfaceLanguage["header_disease_group"],
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
                  Flexible(
                    child: Stack(
                      children: <Widget>[
                        CarouselSlider(
                          options: CarouselOptions(
                            height: double.maxFinite,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _controllerSelectFrame = index;
                              });
                            },
                          ),
                          items: _selectionDiagnoseGroupFrame(),
                        ),
                        Positioned(
                          bottom: 15.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _selectionDiagnoseGroupFrame().length,
                                (index) {
                                  return Container(
                                    width: _controllerSelectFrame == index ? 15.0 : 10.0,
                                    height: _controllerSelectFrame == index ? 15.0 : 10.0,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _controllerSelectFrame == index ? Colors.blue.shade800 : Colors.blue.shade500.withOpacity(0.7),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buttonDiagnoseGroupSelect(int keyGroup, String titleGroup, List<int>? diagnoseChartList, {bool isBold = false}) {
    return Container(
      height: 60.0,
      // constraints: BoxConstraints(maxWidth: 260.0),
      constraints: BoxConstraints(maxWidth: 400.0),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          primary: Colors.white.withOpacity(0.7),
          onPrimary: Colors.blue.shade100,
          onSurface: Colors.blue.shade800,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue.shade600,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(80.0),
          ),
        ),
        child: Container(
          height: 60.0,
          alignment: Alignment.center,
          child: Text(
            titleGroup,
            style: TextStyle(
              color: Colors.blue.shade600,
              fontSize: 18.0,
              fontWeight: isBold == true ? FontWeight.w600 : FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onPressed: diagnoseChartList != null && diagnoseChartList.length > 0
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectDiagnoseListSC(
                      groupKey: keyGroup,
                      groupTitle: titleGroup,
                      diagnoseChartList: diagnoseChartList,
                    ),
                  ),
                );
              }
            : null,
      ),
    );
  }

  List<Container> _setDiagnoseGroup({required int startIndex, required int lastIndex}) {
    List<Container> _resultwidget = [];

    for (var i = startIndex; i <= lastIndex; i++) {
      _resultwidget.add(_buttonDiagnoseGroup[i]);
    }

    return _resultwidget;
  }

  List<Container> _selectionDiagnoseGroupFrame() {
    return [
      Container(
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 5.0, bottom: 30.0),
                constraints: BoxConstraints(maxHeight: 1000.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _setDiagnoseGroup(
                    startIndex: 0,
                    lastIndex: 5,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Hero(
                tag: "tun_rokh_body",
                child: Image(
                  image: AssetImage("assets/images/tun_rokh_body_and_inside_part_1.png"),
                  height: double.maxFinite,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Image(
                image: AssetImage("assets/images/tun_rokh_body_and_inside_part_2.png"),
                height: double.maxFinite,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerRight,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.0, right: 10.0, bottom: 30.0),
                constraints: BoxConstraints(maxHeight: 1000.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _setDiagnoseGroup(
                    startIndex: 6,
                    lastIndex: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
