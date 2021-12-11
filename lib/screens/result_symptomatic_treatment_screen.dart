import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:tun_rokh_demo/data/userinterface_language.dart';
import 'package:tun_rokh_demo/data/flowchart_language.dart';

class ResultSymptomaticTreatmentSC extends StatefulWidget {
  ResultSymptomaticTreatmentSC({
    required this.chartId,
    required this.frameId,
    this.commandHealthDetail,
    this.commandHealthDescription,
    this.drugRcommend,
    this.treatmentRecommend,
  });
  static String nameScreen = "ResultSymptomaticTreatmentSC";
  final int chartId;
  final String frameId;
  final String? commandHealthDetail;
  final String? commandHealthDescription;
  final List<String>? drugRcommend;
  final List<String>? treatmentRecommend;

  @override
  _ResultSymptomaticTreatmentSCState createState() => _ResultSymptomaticTreatmentSCState();
}

class _ResultSymptomaticTreatmentSCState extends State<ResultSymptomaticTreatmentSC> {
  String? _commandHealthDetail;
  String? _description;
  List<String>? _drugRcommend;
  List<String>? _treatmentRecommend;
  bool _trackAdviceDiagnoseCard = true;
  bool _trackAdviceDrugCard = false;
  bool _trackAdvicetreatmentCard = false;

  @override
  Widget build(BuildContext context) {
    _commandHealthDetail = widget.commandHealthDetail == null ? mainFlowChartLanguage[widget.chartId]["commandHealthDetailList"][widget.frameId] : widget.commandHealthDetail;
    _description = widget.commandHealthDescription == null ? mainFlowChartLanguage[widget.chartId]["symptomaticTreatmentDescription"][widget.frameId] : widget.commandHealthDescription;
    _drugRcommend = widget.drugRcommend == null ? mainFlowChartLanguage[widget.chartId]["commandHealthDrugRcommendList"][widget.frameId] : widget.drugRcommend;
    _treatmentRecommend = widget.treatmentRecommend == null ? mainFlowChartLanguage[widget.chartId]["symptomaticTreatmentRecommend"][widget.frameId] : widget.treatmentRecommend;

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
                                color: Colors.blue.shade900,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.diagnoses,
                                size: 45.0,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                mainUserInterfaceLanguage["header_symptomatic_treatment"],
                                style: TextStyle(
                                  color: Colors.blue.shade900,
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
        ),
      ),
    );
  }

  List<Widget> _createAdviceTreatmentStepTag() {
    List<String>? stepData = _treatmentRecommend;
    List<Widget> widgetResult = [];

    if (stepData != null) {
      stepData.asMap().forEach(
        (index, value) {
          widgetResult.add(
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 3.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${(index + 1)}.",
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return widgetResult;
  }

  List<Widget> _setDiagnoseContent() {
    List<Widget> _createAdviceDrugList() {
      List<Widget> _widgetResult = [];

      _drugRcommend!.asMap().forEach(
        (index, value) {
          _widgetResult.add(
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 3.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${(index + 1)}.",
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      _widgetResult.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(
            height: 1.0,
            color: Colors.red.shade800.withOpacity(0.7),
          ),
        ),
      );

      _widgetResult.add(
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          width: double.maxFinite,
          child: Text(
            mainUserInterfaceLanguage["warning"],
            style: TextStyle(
              color: Colors.red.shade500,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

      mainUserInterfaceLanguage["advice_use_drug"].forEach(
        (value) {
          _widgetResult.add(
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "**",
                    style: TextStyle(
                      color: Colors.red.shade500,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.red.shade500,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      return _widgetResult;
    }

    List<Widget> _widgetResult = [];

    if (_commandHealthDetail != null) {
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
                  _commandHealthDetail ?? "",
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

    if (_drugRcommend != null) {
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
              _trackAdviceDrugCard == false ? mainUserInterfaceLanguage["show"] : mainUserInterfaceLanguage["hide"],
              style: TextStyle(
                color: _trackAdviceDrugCard == false ? Colors.blue.shade800 : Colors.blueGrey.shade800,
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
                  FontAwesomeIcons.pills,
                  size: 18.0,
                  color: Colors.blue.shade800,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${mainUserInterfaceLanguage["header_advice_drug"]}",
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "${_drugRcommend!.length} ${mainUserInterfaceLanguage["list_item"]}",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
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
              Container(
                width: double.maxFinite,
                constraints: BoxConstraints(maxHeight: 170.0),
                padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 15.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _createAdviceDrugList(),
                  ),
                ),
              ),
            ],
            onExpansionChanged: (val) => setState(
              () {
                _trackAdviceDrugCard = val;
              },
            ),
          ),
        ),
      );
    }

    if (_treatmentRecommend != null) {
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
              _trackAdvicetreatmentCard == false ? mainUserInterfaceLanguage["show"] : mainUserInterfaceLanguage["hide"],
              style: TextStyle(
                color: _trackAdvicetreatmentCard == false ? Colors.blue.shade800 : Colors.blueGrey.shade800,
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
                  FontAwesomeIcons.fileMedical,
                  size: 18.0,
                  color: Colors.blue.shade800,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${mainUserInterfaceLanguage["advice_symptomatic_treatment"]}",
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "${_treatmentRecommend!.length} ${mainUserInterfaceLanguage["list_item"]}",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
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
              Container(
                width: double.maxFinite,
                constraints: BoxConstraints(maxHeight: 170.0),
                padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 15.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      _treatmentRecommend!.length,
                      (index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "${(index + 1)}.",
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Text(
                                  _treatmentRecommend![index],
                                  style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
            onExpansionChanged: (val) => setState(
              () {
                _trackAdvicetreatmentCard = val;
              },
            ),
          ),
        ),
      );
    }

    return _widgetResult;
  }
}
