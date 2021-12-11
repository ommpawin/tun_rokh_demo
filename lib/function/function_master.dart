import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tun_rokh_demo/model/current_question_store.dart';
import 'package:tun_rokh_demo/data/flowchart_process.dart';
import 'package:tun_rokh_demo/data/flowchart_language.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';

String? kfuncMatchQuestionFlowChart(int chartId, String frameId) {
  return mainFlowChartLanguage[chartId]["questionFlowChart"][frameId];
}

List<String>? kfuncMatchMultiAnswerSelectTextList(int chartId, String frameId) {
  return mainFlowChartLanguage[chartId]["multiAnswerSelectTextList"][frameId];
}

String? kfuncMatchCommandHealthDetailList(int chartId, String frameId) {
  return mainFlowChartLanguage[chartId]["commandHealthDetailList"][frameId];
}

List<String>? kfuncMatchCommandHealthDrugRcommendList(int chartId, String frameId) {
  return mainFlowChartLanguage[chartId]["commandHealthDrugRcommendList"][frameId];
}

List<String>? kfuncMatchCommandHealthTreatmentRecommendList(int chartId, String frameId) {
  return mainFlowChartLanguage[chartId]["commandHealthTreatmentRecommendList"][frameId];
}

String? kfuncMatchSymptomaticTreatmentDescription(int chartId, String frameId) {
  return mainFlowChartLanguage[chartId]["symptomaticTreatmentDescription"][frameId];
}

List<String>? kfuncMatchSymptomaticTreatmentRecommend(int chartId, String frameId) {
  return mainFlowChartLanguage[chartId]["symptomaticTreatmentRecommend"][frameId];
}

Map<String, dynamic> kfuncNextFrameQuestionPack({
  required String frameId,
}) {
  return {
    "runType": "@NextFrameQuestion",
    "packageType": {
      "frameId": frameId,
    }
  };
}

Map<String, dynamic> kfuncSwitchFrameQuestionPack({
  required int chartId,
  String frameId = "1.0",
}) {
  return {
    "runType": "@SwitchFrameQuestion",
    "packageType": {
      "chartId": chartId,
      "frameId": frameId,
    }
  };
}

Map<String, dynamic> kfuncDiagnoseResultPack({
  required double commandHealthLevel,
  required String? commandHealthDetail,
}) {
  return {
    "runType": "@DiagnoseResult",
    "packageType": {
      "commandHealthLevel": commandHealthLevel,
      "commandHealthDetail": commandHealthDetail,
    }
  };
}

Map<String, dynamic> kfuncDiagnoseResultDetailPack({
  required String? commandHealthDetail,
  List<String>? drugRcommend,
  List<String>? treatmentRecommend,
  required List<String>? diseaseId,
  bool diseaseOther = false,
}) {
  return {
    "runType": "@DiagnoseResultDetail",
    "packageType": {
      "commandHealthDetail": commandHealthDetail,
      "drugRcommend": drugRcommend,
      "treatmentRecommend": treatmentRecommend,
      "diseaseId": diseaseId,
      "diseaseOther": diseaseOther,
    }
  };
}

Map<String, dynamic> kfuncSymptomaticTreatmentResultPack({
  required int chartId,
  required String frameId,
  String? commandHealthDetail,
  String? commandHealthDescription,
  List<String>? drugRcommend,
  List<String>? treatmentRecommend,
}) {
  return {
    "runType": "@SymptomaticTreatmentResult",
    "packageType": {
      "chartId": chartId,
      "frameId": frameId,
      "commandHealthDetail": commandHealthDetail,
      "commandHealthDescription": commandHealthDescription,
      "drugRcommend": drugRcommend,
      "treatmentRecommend": treatmentRecommend,
    }
  };
}

Map<String, dynamic> kfuncSelectDiagnoseGroupInTimelineDataPack({
  required int groupKey
}) {
  return {
    "historyType": "SelectDiagnoseGroup",
    "packageType": {
      "groupKey": groupKey,
    }
  };
}

Map<String, dynamic> kfuncSelectDiagnoseListInTimelineDataPack({
  required int chartId,
}) {
  return {
    "historyType": "SelectDiagnoseList",
    "packageType": {
      "chartId": chartId,
    }
  };
}

Map<String, dynamic>? kfuncDiagnoseInTimelineDataPack({
  required int chartId,
  required String frameId,
  required String questionType,
  required int answerType,
  required List<int> answerId,
}) {
  return answerType != -1
      ? {
          "historyType": "Question",
          "packageType": {
            "chartId": chartId,
            "frameId": frameId,
            "questionType": questionType,
            "answerType": answerType,
            "answerId": answerId,
          }
        }
      : null;
}

Map<String, dynamic> _diagnoseResultInTimelineDataPack({
  required double commandHealthLevel,
  required String? commandHealthDetail,
}) {
  return {
    "historyType": "DiagnoseResult",
    "packageType": {
      "commandHealthLevel": commandHealthLevel,
      "commandHealthDetail": commandHealthDetail,
    }
  };
}

Map<String, dynamic> _diagnoseResultDetailInTimelineDataPack({
  required String? commandHealthDetail,
  required List<String>? drugRcommend,
  required List<String>? treatmentRecommend,
  required List<String>? diseaseId,
  required bool diseaseOther,
}) {
  return {
    "historyType": "DiagnoseResultDetail",
    "packageType": {
      "commandHealthDetail": commandHealthDetail,
      "drugRcommend": drugRcommend,
      "treatmentRecommend": treatmentRecommend,
      "diseaseId": diseaseId,
      "diseaseOther": diseaseOther,
    }
  };
}

Map<String, dynamic> _symptomaticTreatmentResultInTimelineDataPack({
  required int chartId,
  required String frameId,
  required String? commandHealthDetail,
  required String? commandHealthDescription,
  required List<String>? drugRcommend,
  required List<String>? treatmentRecommend,
}) {
  return {
    "historyType": "SymptomaticTreatment",
    "packageType": {
      "chartId": chartId,
      "frameId": frameId,
      "commandHealthDetail": commandHealthDetail,
      "commandHealthDescription": commandHealthDescription,
      "drugRcommend": drugRcommend,
      "treatmentRecommend": treatmentRecommend,
    }
  };
}

void kfuncControlQuestionPage({
  required BuildContext context,
  required CurrentQuestionStore valueProvider,
  required Map<String, dynamic> package,
  required Map<String, dynamic>? diagnoseTimeline,
}) {
  String _runtype = package["runType"];
  Map<String, dynamic> _data = package["packageType"];

  if (diagnoseTimeline != null) {
    valueProvider.updateDiagnoseTimeline(diagnoseTimeline);
  }

  if (_runtype == "@NextFrameQuestion") {
    valueProvider.updataNotify();
    _nextFrameQuestion(
      context: context,
      valueProvider: valueProvider,
      frameId: _data["frameId"],
    );
  } else if (_runtype == "@DiagnoseResult") {
    valueProvider.updateDiagnoseTimeline(
      _diagnoseResultInTimelineDataPack(
        commandHealthLevel: _data["commandHealthLevel"],
        commandHealthDetail: _data["commandHealthDetail"],
      ),
    );

    _diagnoseResult(
      context: context,
      commandHealthLevel: _data["commandHealthLevel"],
      commandHealthDetail: _data["commandHealthDetail"],
    );
  } else if (_runtype == "@DiagnoseResultDetail") {
    valueProvider.updateDiagnoseTimeline(
      _diagnoseResultDetailInTimelineDataPack(
        commandHealthDetail: _data["commandHealthDetail"],
        drugRcommend: _data["drugRcommend"],
        treatmentRecommend: _data["treatmentRecommend"],
        diseaseId: _data["diseaseId"],
        diseaseOther: _data["diseaseOther"],
      ),
    );

    _diagnoseResultDetail(
      context: context,
      commandHealthDetail: _data["commandHealthDetail"],
      drugRcommend: _data["drugRcommend"],
      treatmentRecommend: _data["treatmentRecommend"],
      diseaseId: _data["diseaseId"],
      diseaseOther: _data["diseaseOther"],
    );
  } else if (_runtype == "@SymptomaticTreatmentResult") {
    valueProvider.updateDiagnoseTimeline(
      _symptomaticTreatmentResultInTimelineDataPack(
        chartId: _data["chartId"],
        frameId: _data["frameId"],
        commandHealthDetail: _data["commandHealthDetail"],
        commandHealthDescription: _data["commandHealthDescription"],
        drugRcommend: _data["drugRcommend"],
        treatmentRecommend: _data["treatmentRecommend"],
      ),
    );

    _symptomaticTreatmentResult(
      context: context,
      chartId: _data["chartId"],
      frameId: _data["frameId"],
      commandHealthDetail: _data["commandHealthDetail"],
      commandHealthDescription: _data["commandHealthDescription"],
      drugRcommend: _data["drugRcommend"],
      treatmentRecommend: _data["treatmentRecommend"],
    );
  } else if (_runtype == "@SwitchFrameQuestion") {
    valueProvider.updataNotify();
    _switchFrameQuestion(
      context: context,
      valueProvider: valueProvider,
      chartId: _data["chartId"],
      frameId: _data["frameId"],
    );
  }
}

void _nextFrameQuestion({
  required BuildContext context,
  required CurrentQuestionStore valueProvider,
  required String frameId,
}) {
  try {
    valueProvider.updateCurrentWidget(
      frameId: frameId,
      currentWidget: mainFlowChart[valueProvider.chartId][frameId],
    );
  } catch (error) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SorryEarlyAccessSC()),
      (route) => false,
    );
  }
}

void _switchFrameQuestion({
  required BuildContext context,
  required CurrentQuestionStore valueProvider,
  required int chartId,
  required String frameId,
}) {
  try {
    valueProvider.updateCurrentWidget(
      chartId: chartId,
      frameId: frameId,
      currentWidget: mainFlowChart[chartId][frameId],
    );
  } catch (error) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SorryEarlyAccessSC()),
      (route) => false,
    );
  }
}

void _diagnoseResult({
  required BuildContext context,
  required double commandHealthLevel,
  required String? commandHealthDetail,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => ResultDiagnoseSC(
        commandHealthLevel: commandHealthLevel,
        commandHealthDetail: commandHealthDetail,
      ),
    ),
    (route) => false,
  );
}

void _diagnoseResultDetail({
  required BuildContext context,
  required String? commandHealthDetail,
  required List<String>? drugRcommend,
  required List<String>? treatmentRecommend,
  required List<String>? diseaseId,
  required bool diseaseOther,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => ResultDetailDiagnoseSC(
        commandHealthDetail: commandHealthDetail,
        drugRcommend: drugRcommend,
        treatmentRecommend: treatmentRecommend,
        diseaseId: diseaseId,
        diseaseOther: diseaseOther,
      ),
    ),
    (route) => false,
  );
}

void _symptomaticTreatmentResult({
  required BuildContext context,
  required int chartId,
  required String frameId,
  required String? commandHealthDetail,
  required String? commandHealthDescription,
  required List<String>? drugRcommend,
  required List<String>? treatmentRecommend,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => ResultSymptomaticTreatmentSC(
        chartId: chartId,
        frameId: frameId,
        commandHealthDetail: commandHealthDetail,
        commandHealthDescription: commandHealthDescription,
        drugRcommend: drugRcommend,
        treatmentRecommend: treatmentRecommend,
      ),
    ),
    (route) => false,
  );
}
