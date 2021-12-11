import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:provider/provider.dart';
import 'package:tun_rokh_demo/model/current_question_store.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/flowchart_language.dart';
import 'package:tun_rokh_demo/data/flowchart_process.dart';

class DiagnoseSC extends StatefulWidget {
  static String nameScreen = "DiagnoseSC";

  @override
  _DiagnoseSCState createState() => _DiagnoseSCState();
}

class _DiagnoseSCState extends State<DiagnoseSC> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentQuestionStore>(
      builder: (context, valProvi, child) => WillPopScope(
        onWillPop: () async {
          _cancelDiagnoseDialog(
            context: context,
            valueProvider: valProvi,
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
                            Icons.clear,
                            color: Colors.red,
                          ),
                          label: Text(
                            mainUserInterfaceLanguage["cancel"],
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
                            _cancelDiagnoseDialog(
                              context: context,
                              valueProvider: valProvi,
                            );
                          },
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(top: 7.0),
                            child: Text(
                              mainUserInterfaceLanguage["header_diagnose"],
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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      constraints: BoxConstraints(maxWidth: 750.0),
                      child: valProvi.currentWidget,
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

  List<Widget> _createDiagnosePointTimeLine({required CurrentQuestionStore valueProvider}) {
    List<Widget> _resultWidget = [];
    int _dataLength = valueProvider.diagnoseTimeline.length;

    IconData? _setIconTimeLine(String historyType, String? questionType, List<int>? answerId) {
      IconData? _resultData;

      if (historyType == "Question") {
        if (questionType == "StartPoint") {
          _resultData = FontAwesomeIcons.stethoscope;
        } else if (questionType == "TwoAnswerOneSelect" || questionType == "MultiAnswerOneSelect") {
          if (answerId!.length == 1 && answerId.contains(0)) {
            _resultData = Icons.close;
          } else {
            _resultData = Icons.done;
          }
        } else if (questionType == "MultiAnswerMultiSelect") {
          if (answerId!.length == 1 && answerId.contains(0)) {
            _resultData = Icons.close;
          } else {
            _resultData = Icons.done_all;
          }
        }
      }

      return _resultData;
    }

    valueProvider.diagnoseTimeline.asMap().forEach(
      (index, element) {
        String _historyType = element["historyType"];
        String? _questionType = element["packageType"]["questionType"];
        List<int>? _answerId = element["packageType"]["answerId"];

        _resultWidget.add(
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == (_dataLength - 1) ? Colors.green.shade400.withOpacity(0.75) : Colors.blue.shade400.withOpacity(0.50),
                      ),
                    ),
                    Icon(
                      _setIconTimeLine(_historyType, _questionType, _answerId),
                      color: Colors.white,
                      size: index == (_dataLength - 1) ? 14.0 : 20.0,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: index != 0,
                child: Container(
                  width: 35.0,
                  child: Divider(
                    color: index == (_dataLength - 1) ? Colors.green.shade400.withOpacity(0.75) : Colors.blue.shade400.withOpacity(0.55),
                    height: 2,
                    thickness: 2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return _resultWidget;
  }

  void _cancelDiagnoseDialog({
    required CurrentQuestionStore valueProvider,
    required BuildContext context,
  }) {
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
                      Icons.clear,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Flexible(
                      child: Text(
                        mainUserInterfaceLanguage["header_cancel_diagnose"],
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
                      mainUserInterfaceLanguage["cancel_diagnose_warning"],
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
                              mainUserInterfaceLanguage["cancel_diagnose"],
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
                              valueProvider.clearCurrentWidget(true);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeSC(),
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
