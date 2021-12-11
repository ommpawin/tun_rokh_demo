import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tun_rokh_demo/model/current_question_store.dart';
import 'package:tun_rokh_demo/function/function_master.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/flowchart_language.dart';

class TwoAnswerOneSelect extends StatefulWidget {
  TwoAnswerOneSelect({
    required this.chartId,
    required this.frameId,
    this.questionTitle,
    required this.yesAnswerAction,
    required this.noAnswerAction,
    this.answerImageTitle,
  });
  final String questionType = "TwoAnswerOneSelect";
  final int chartId;
  final String frameId;
  String? questionTitle;
  final Map<String, dynamic> yesAnswerAction;
  final Map<String, dynamic> noAnswerAction;
  final List<String?>? answerImageTitle;

  @override
  _TwoAnswerOneSelectState createState() => _TwoAnswerOneSelectState();
}

class _TwoAnswerOneSelectState extends State<TwoAnswerOneSelect> {
  int _nextSelection = -1;
  late String _questionTitle;
  String _localImagePath = "assets/images/answer_images/";
  String _imageFileType = ".png";

  @override
  Widget build(BuildContext context) {
    _questionTitle = widget.questionTitle == null ? mainFlowChartLanguage[widget.chartId]["questionFlowChart"][widget.frameId] : widget.questionTitle;

    return Consumer<CurrentQuestionStore>(
      builder: (context, valProvi, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.frameId,
                      style: TextStyle(
                        color: Colors.blue.shade800.withOpacity(0.5),
                        fontSize: 8.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    child: Text(
                      _questionTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5.0),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      child: Text(
                        _setAdviceSlectAnswer(mainUserInterfaceLanguage["select_one_answer_below"], "00", 2),
                        style: TextStyle(
                          color: Colors.blue.shade800.withOpacity(1.0),
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          height: 160.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              primary: _nextSelection == 1 ? Colors.blue.shade500 : Colors.white.withOpacity(0.7),
                              onPrimary: Colors.blue.shade200,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: _nextSelection == 1 ? Colors.blue.shade500 : Colors.blue.shade400, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          color: _nextSelection == 1 ? Colors.white : Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: widget.answerImageTitle != null && widget.answerImageTitle![1] != null
                                            ? Image(
                                                image: AssetImage("$_localImagePath${widget.answerImageTitle![1]}$_imageFileType"),
                                                width: 71.0,
                                                height: 71.0,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.done,
                                                    size: 70.0,
                                                    color: _nextSelection == 1 ? Colors.blue.shade500 : Colors.blue.shade600,
                                                  );
                                                },
                                              )
                                            : Icon(
                                                Icons.done,
                                                size: 70.0,
                                                color: _nextSelection == 1 ? Colors.blue.shade500 : Colors.blue.shade600,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 60.0,
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    mainUserInterfaceLanguage["yes_answer_text"],
                                    style: TextStyle(
                                      color: _nextSelection == 1 ? Colors.white : Colors.blue.shade600,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    minFontSize: 10.0,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _nextSelection = 1;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 160.0,
                          height: 160.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              primary: _nextSelection == 0 ? Colors.blue.shade500 : Colors.white.withOpacity(0.7),
                              onPrimary: Colors.blue.shade200,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: _nextSelection == 0 ? Colors.blue.shade500 : Colors.blue.shade400, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          color: _nextSelection == 0 ? Colors.white : Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: widget.answerImageTitle != null && widget.answerImageTitle![0] != null
                                            ? Image(
                                                image: AssetImage("$_localImagePath${widget.answerImageTitle![0]}$_imageFileType"),
                                                width: 71.0,
                                                height: 71.0,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.close,
                                                    size: 70.0,
                                                    color: _nextSelection == 0 ? Colors.blue.shade500 : Colors.blue.shade600,
                                                  );
                                                },
                                              )
                                            : Icon(
                                                Icons.close,
                                                size: 70.0,
                                                color: _nextSelection == 0 ? Colors.blue.shade500 : Colors.blue.shade600,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 60.0,
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    mainUserInterfaceLanguage["no_answer_text"],
                                    style: TextStyle(
                                      color: _nextSelection == 0 ? Colors.white : Colors.blue.shade600,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    minFontSize: 10.0,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _nextSelection = 0;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 170.0,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          primary: _nextSelection != -1 ? Colors.green.shade500 : Colors.white.withOpacity(0.7),
                          onPrimary: _nextSelection != -1 ? Colors.green.shade100 : Colors.grey.shade200,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: _nextSelection != -1 ? Colors.green.shade500 : Colors.green.shade300, width: 1.0),
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
                                _nextSelection != -1 ? Icons.add_circle_outlined : Icons.add_circle_outline_outlined,
                                size: 25.0,
                                color: _nextSelection != -1 ? Colors.white : Colors.green.shade300,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                mainUserInterfaceLanguage["save_answer"],
                                style: TextStyle(
                                  color: _nextSelection != -1 ? Colors.white : Colors.green.shade300,
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
                          if (_nextSelection != -1) {
                            if (_nextSelection == 0) {
                              kfuncControlQuestionPage(
                                context: context,
                                valueProvider: valProvi,
                                package: widget.noAnswerAction,
                                diagnoseTimeline: kfuncDiagnoseInTimelineDataPack(
                                  chartId: widget.chartId,
                                  frameId: widget.frameId,
                                  questionType: widget.questionType,
                                  answerType: 0,
                                  answerId: [0],
                                ),
                              );
                            } else if (_nextSelection == 1) {
                              kfuncControlQuestionPage(
                                context: context,
                                valueProvider: valProvi,
                                package: widget.yesAnswerAction,
                                diagnoseTimeline: kfuncDiagnoseInTimelineDataPack(
                                  chartId: widget.chartId,
                                  frameId: widget.frameId,
                                  questionType: widget.questionType,
                                  answerType: 1,
                                  answerId: [1],
                                ),
                              );
                            }
                            _nextSelection = -1;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _setAdviceSlectAnswer(String advice, String wordReplace, int countAnswer) {
    return advice.replaceAll(wordReplace, countAnswer.toString());
  }
}
