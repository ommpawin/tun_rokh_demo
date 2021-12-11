import 'package:flutter/material.dart';
import 'package:tun_rokh_demo/function/function_master.dart';
import 'dart:ui' show ImageFilter;
import 'package:provider/provider.dart';
import 'package:tun_rokh_demo/model/current_question_store.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/flowchart_language.dart';

class SelectDiagnoseListSC extends StatefulWidget {
  SelectDiagnoseListSC({
    required this.groupKey,
    required this.groupTitle,
    required this.diagnoseChartList,
  });
  static String nameScreen = "SelectDiagnoseSC";
  final int groupKey;
  final String groupTitle;
  final List<int> diagnoseChartList;

  @override
  _SelectDiagnoseListSCState createState() => _SelectDiagnoseListSCState();
}

class _SelectDiagnoseListSCState extends State<SelectDiagnoseListSC> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentQuestionStore>(
      builder: (context, valProvi, child) => Scaffold(
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
                          Navigator.pop(context);
                        },
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(top: 7.0),
                          child: Text(
                            mainUserInterfaceLanguage["header_select_diagnose"],
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
                Divider(
                  color: Colors.blue.shade900.withOpacity(0.5),
                  thickness: 1,
                  indent: 15.0,
                  endIndent: 15.0,
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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      constraints: BoxConstraints(maxWidth: 550.0),
                      child: Scrollbar(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 15.0),
                          physics: BouncingScrollPhysics(),
                          children: _setDiagnoseListItem(valProvi, context),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _setDiagnoseListItem(CurrentQuestionStore valueProvider, BuildContext context) {
    List<Widget> _resultWidget = [];

    _resultWidget.add(
      Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 7.0),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.groupTitle,
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Text(
              "${widget.diagnoseChartList.length} ${mainUserInterfaceLanguage["list_item"]}",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );

    widget.diagnoseChartList.forEach(
      (idChart) {
        Map<String, dynamic> _diseaseData = mainFlowChartLanguage[idChart];
        _resultWidget.add(
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                primary: Colors.white.withOpacity(0.7),
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
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.heartbeat,
                          size: 18.0,
                          color: Colors.blue.shade800,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                          child: Text(
                            _diseaseData["nameFlowChart"],
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onPressed: () {
                _diagnoseChartDialog(
                  valueProvider: valueProvider,
                  context: context,
                  chartId: idChart,
                  chartTitle: _diseaseData["nameFlowChart"],
                  chartDetail: _diseaseData["definitionsFlowChart"],
                );
              },
            ),
          ),
        );
      },
    );

    return _resultWidget;
  }

  void _diagnoseChartDialog({
    required CurrentQuestionStore valueProvider,
    required BuildContext context,
    required int chartId,
    required String chartTitle,
    required String? chartDetail,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.blue.shade50,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.blue.shade600,
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
                    FaIcon(
                      FontAwesomeIcons.heartbeat,
                      size: 18.0,
                      color: Colors.blue.shade800,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        chartTitle,
                        style: TextStyle(
                          color: Colors.blue.shade800,
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
                color: Colors.blue.shade800.withOpacity(0.7),
              ),
              Visibility(
                visible: chartDetail != null && chartDetail.length >= 10,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${mainUserInterfaceLanguage["description"]} : ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: chartDetail,
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        height: 1.0,
                        color: Colors.blue.shade800.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      mainUserInterfaceLanguage["start_diagnose_warning"],
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
                              mainUserInterfaceLanguage["cancel"],
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
                              mainUserInterfaceLanguage["start_diagnose"],
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
                              valueProvider.updateDiagnoseTimeline(
                                kfuncSelectDiagnoseGroupInTimelineDataPack(groupKey: widget.groupKey),
                              );
                              valueProvider.updateDiagnoseTimeline(
                                kfuncSelectDiagnoseListInTimelineDataPack(chartId: chartId),
                              );
                              valueProvider.intiCurrentWidget(chartId: chartId);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiagnoseSC(),
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
