import 'package:tun_rokh_demo/function/function_master.dart';
import 'package:tun_rokh_demo/class/export_question_class.dart';

Map<int, dynamic> mainFlowChart = {
  1: {
    "1.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "1.0",
      answerImageTitle: [null, "i_1_1", "i_1_2", "i_1_3", "i_1_4"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncNextFrameQuestionPack(frameId: "1.1");
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "2.0"),
    ),
    "1.1": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "1.1",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_5", "i_1_6"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.1"),
            diseaseId: ["66", "81", "82"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "1.2"),
    ),
    "1.2": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "1.2",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_7", "i_1_8"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.1"),
            diseaseId: ["224"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "1.3"),
    ),
    "1.3": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "1.3",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_9", null, null],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.1"),
            diseaseId: ["64"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "1.4"),
    ),
    "1.4": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "1.4",
      answerImageTitle: [null, "i_1_10"],
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: null,
        diseaseId: ["218.1"],
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "1.5"),
    ),
    "1.5": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "1.5",
      answerImageTitle: [null, "i_1_11"],
      yesAnswerAction: kfuncNextFrameQuestionPack(frameId: "1.6"),
      noAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: null,
        diseaseId: ["65", "227"],
      ),
    ),
    "1.6": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "1.6",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_12", "i_1_13", "i_1_63"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            diseaseId: ["67"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "1.7"),
    ),
    "1.7": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "1.7",
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.7-1"),
        diseaseId: ["68"],
        drugRcommend: kfuncMatchCommandHealthDrugRcommendList(1, "1.7-1"),
      ),
      noAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.7-2"),
        diseaseId: null,
      ),
    ),
    "2.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "2.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultPack(
            commandHealthLevel: 5.0,
            commandHealthDetail: null,
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "3.0"),
    ),
    "3.0": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "3.0",
      answerImageTitle: [null, "i_1_15"],
      yesAnswerAction: kfuncDiagnoseResultPack(
        commandHealthLevel: 4.0,
        commandHealthDetail: null,
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "4.0"),
    ),
    "4.0": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "4.0",
      answerImageTitle: [null, "i_1_16"],
      yesAnswerAction: kfuncNextFrameQuestionPack(frameId: "4.1"),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "5.0"),
    ),
    "4.1": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "4.1",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_17", "i_1_18"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultPack(
            commandHealthLevel: 3.6,
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.7-2"),
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "4.2"),
    ),
    "4.2": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "4.2",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_19", "i_1_20", "i_1_21"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            diseaseId: ["111"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "4.3"),
    ),
    "4.3": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "4.3",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_22", "i_1_7"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            diseaseId: ["224"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "4.4"),
    ),
    "4.4": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "4.4",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_23", "i_1_24", "i_1_25"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            diseaseId: ["95"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "4.5"),
    ),
    "4.5": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "4.5",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_26", "i_1_27"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultPack(
            commandHealthLevel: 3.6,
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.7-2"),
          );
        }

        return _result;
      },
      noAnswerAction: kfuncDiagnoseResultPack(
        commandHealthLevel: 3.6,
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.7-2"),
      ),
    ),
    "5.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "5.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, null, "i_1_22"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncNextFrameQuestionPack(frameId: "5.1");
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "6.0"),
    ),
    "5.1": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "5.1",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_28", "i_1_29", null, "i_1_7"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0) || _selectionIdList.contains(1) && _selectionIdList.contains(4) && !_selectionIdList.contains(0) || _selectionIdList.contains(2) && _selectionIdList.contains(4) && !_selectionIdList.contains(0) || _selectionIdList.contains(3) && _selectionIdList.contains(4) && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "5.1"),
            diseaseId: ["226"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "5.2"),
    ),
    "5.2": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "5.2",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_22", "i_1_7", "i_1_8"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0) || _selectionIdList.contains(1) && _selectionIdList.contains(2) && !_selectionIdList.contains(0) || _selectionIdList.contains(1) && _selectionIdList.contains(3) && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "5.2"),
            diseaseId: ["224"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "5.3"),
    ),
    "5.3": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "5.3",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_30", "i_1_31"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "5.3"),
            diseaseId: ["137"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "5.4"),
    ),
    "5.4": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "5.4",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_32", "i_1_33", "i_1_34", "i_1_35", null],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (!_selectionIdList.contains(0)) {
          if (_selectionIdList.length == _answerDataLength || _selectionIdList.contains(1) && _selectionIdList.contains(4) || _selectionIdList.contains(1) && _selectionIdList.contains(5) || _selectionIdList.contains(2) && _selectionIdList.contains(4) || _selectionIdList.contains(2) && _selectionIdList.contains(5) || _selectionIdList.contains(3) && _selectionIdList.contains(4) || _selectionIdList.contains(3) && _selectionIdList.contains(5)) {
            _result = kfuncDiagnoseResultDetailPack(
              commandHealthDetail: null,
              diseaseId: ["227"],
            );
          }
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "5.5"),
    ),
    "5.5": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "5.5",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "5.5-1"),
            diseaseId: ["37"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncDiagnoseResultPack(
        commandHealthLevel: 3.6,
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "5.5-1"),
      ),
    ),
    "6.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "6.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_36", "i_1_37", "i_1_38"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultPack(
            commandHealthLevel: 5.0,
            commandHealthDetail: null,
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "7.0"),
    ),
    "7.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "7.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_39", "i_1_39", "i_1_26", "i_1_40", "i_1_41"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultPack(
            commandHealthLevel: 5.0,
            commandHealthDetail: null,
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "8.0"),
    ),
    "8.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "8.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_42", "i_1_43"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "8.0"),
            diseaseId: ["19"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "9.0"),
    ),
    "9.0": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "9.0",
      answerImageTitle: [null, "i_1_28"],
      yesAnswerAction: kfuncNextFrameQuestionPack(frameId: "9.1"),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "10.0"),
    ),
    "9.1": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "9.1",
      answerImageTitle: [null, "i_1_7"],
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "5.1"),
        diseaseId: ["226"],
      ),
      noAnswerAction: kfuncDiagnoseResultPack(
        commandHealthLevel: 3.6,
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.7-2"),
      ),
    ),
    "10.0": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "10.0",
      answerImageTitle: [null, "i_1_46"],
      yesAnswerAction: kfuncNextFrameQuestionPack(frameId: "10.1"),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "11.0"),
    ),
    "10.1": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "10.1",
      answerImageTitle: [null, "i_1_44"],
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: null,
        diseaseId: ["136"],
      ),
      noAnswerAction: kfuncDiagnoseResultPack(
        commandHealthLevel: 3.6,
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "1.7-2"),
      ),
    ),
    "11.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "11.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_45", "i_1_45"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncNextFrameQuestionPack(frameId: "11.1");
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "12.0"),
    ),
    "11.1": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "11.1",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_29", "i_1_47"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "11.1-1"),
            diseaseId: ["9"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "11.1-1"),
        diseaseId: ["8"],
      ),
    ),
    "12.0": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "12.0",
      answerImageTitle: [null, "i_1_48"],
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "11.1-1"),
        diseaseId: ["61"],
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "13.0"),
    ),
    "13.0": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "13.0",
      answerImageTitle: [null, "i_1_49"],
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "13.0"),
        diseaseId: ["192.1", "192.2", "192.3", "192.4", "192.5"],
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "14.0"),
    ),
    "14.0": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "14.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, null, "i_1_50", "i_1_3", "i_1_51", "i_1_52", "i_1_10"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "14.0"),
            diseaseId: ["218.1"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "15.0"),
    ),
    "15.0": MultiAnswerOneSelect(
      chartId: 1,
      frameId: "15.0",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_53", "i_1_17", "i_1_49", "i_1_54", "i_1_55", "i_1_56", "i_1_57", "i_1_58"],
      selectAnswerAction: [
        kfuncSwitchFrameQuestionPack(chartId: 30),
        kfuncSwitchFrameQuestionPack(chartId: 38),
        kfuncSwitchFrameQuestionPack(chartId: 63),
        kfuncSwitchFrameQuestionPack(chartId: 36),
        kfuncSwitchFrameQuestionPack(chartId: 33),
        kfuncSwitchFrameQuestionPack(chartId: 33),
        kfuncSwitchFrameQuestionPack(chartId: 47),
        kfuncSwitchFrameQuestionPack(chartId: 54),
      ],
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "16.0"),
    ),
    "16.0": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "16.0",
      yesAnswerAction: kfuncNextFrameQuestionPack(frameId: "16.1"),
      noAnswerAction: kfuncSymptomaticTreatmentResultPack(
        chartId: 1,
        frameId: "17.0",
      ),
    ),
    "16.1": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "16.1",
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "16.1"),
        diseaseId: ["225"],
        drugRcommend: kfuncMatchCommandHealthDrugRcommendList(1, "16.1"),
        treatmentRecommend: kfuncMatchCommandHealthTreatmentRecommendList(1, "16.1"),
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "16.2"),
    ),
    "16.2": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "16.2",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_59", "i_1_60"],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "16.1"),
            diseaseId: ["225"],
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(1, "16.1"),
            treatmentRecommend: kfuncMatchCommandHealthTreatmentRecommendList(1, "16.1"),
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "16.3"),
    ),
    "16.3": TwoAnswerOneSelect(
      chartId: 1,
      frameId: "16.3",
      answerImageTitle: [null, "i_1_61"],
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "16.1"),
        drugRcommend: kfuncMatchCommandHealthDrugRcommendList(1, "16.1"),
        treatmentRecommend: kfuncMatchCommandHealthTreatmentRecommendList(1, "16.1"),
        diseaseId: ["5"],
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "16.4"),
    ),
    "16.4": MultiAnswerMultiSelect(
      chartId: 1,
      frameId: "16.4",
      questionTitle: kfuncMatchQuestionFlowChart(1, "1.0"),
      answerImageTitle: [null, "i_1_62", "i_1_25", null],
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(1, "16.4"),
            diseaseId: ["37"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncSymptomaticTreatmentResultPack(
        chartId: 1,
        frameId: "17.0",
      ),
    ),
  },
  2: {
    "1.0": TwoAnswerOneSelect(
      chartId: 2,
      frameId: "1.0",
      answerImageTitle: null,
      yesAnswerAction: kfuncSwitchFrameQuestionPack(chartId: 3),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "2.0"),
    ),
    "2.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "2.0",
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            diseaseId: ["14", "19", "20"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "3.0"),
    ),
    "3.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "3.0",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            diseaseId: ["14", "237.6"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "4.0"),
    ),
    "4.0": TwoAnswerOneSelect(
      chartId: 2,
      frameId: "4.0",
      answerImageTitle: null,
      yesAnswerAction: kfuncSwitchFrameQuestionPack(
        chartId: 38,
        frameId: "3.1",
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "5.0"),
    ),
    "5.0": TwoAnswerOneSelect(
      chartId: 2,
      frameId: "5.0",
      answerImageTitle: null,
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "5.0"),
        drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "5.0"),
        diseaseId: ["15", "19"],
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "6.0"),
    ),
    "6.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "6.0",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "6.0"),
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "5.0"),
            treatmentRecommend: kfuncMatchCommandHealthTreatmentRecommendList(2, "6.0"),
            diseaseId: ["11"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "7.0"),
    ),
    "7.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "7.0",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "7.0"),
            diseaseId: ["163"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "8.0"),
    ),
    "8.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "8.0",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: null,
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "7.0"),
            diseaseId: ["26"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "9.0"),
    ),
    "9.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "9.0",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "9.0"),
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "7.0"),
            diseaseId: ["8"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "10.0"),
    ),
    "10.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "10.0",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length == _answerDataLength && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "10.0"),
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "7.0"),
            diseaseId: ["13"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "11.0"),
    ),
    "11.0": TwoAnswerOneSelect(
      chartId: 2,
      frameId: "11.0",
      answerImageTitle: null,
      yesAnswerAction: kfuncNextFrameQuestionPack(frameId: "11.1"),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "12.0"),
    ),
    "11.1": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "11.1",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "11.1-1"),
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "5.0"),
            diseaseId: ["3"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncSymptomaticTreatmentResultPack(
        chartId: 2,
        frameId: "11.1-2",
        drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "5.0"),
      ),
    ),
    "12.0": TwoAnswerOneSelect(
      chartId: 2,
      frameId: "12.0",
      answerImageTitle: null,
      yesAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "12.0"),
        drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "5.0"),
        diseaseId: ["1"],
      ),
      noAnswerAction: kfuncNextFrameQuestionPack(frameId: "13.0"),
    ),
    "13.0": MultiAnswerMultiSelect(
      chartId: 2,
      frameId: "12.0",
      questionTitle: kfuncMatchQuestionFlowChart(2, "2.0"),
      answerImageTitle: null,
      selectAnswerConditionAction: (_selectionIdList, _answerDataLength) {
        Map<String, dynamic>? _result;

        if (_selectionIdList.length > 0 && !_selectionIdList.contains(0)) {
          _result = kfuncDiagnoseResultDetailPack(
            commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "13.0-1"),
            drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "5.0"),
            treatmentRecommend: kfuncMatchCommandHealthTreatmentRecommendList(2, "13.0-1"),
            diseaseId: ["2"],
          );
        }

        return _result;
      },
      noAnswerAction: kfuncDiagnoseResultDetailPack(
        commandHealthDetail: kfuncMatchCommandHealthDetailList(2, "13.0-1"),
        drugRcommend: kfuncMatchCommandHealthDrugRcommendList(2, "5.0"),
        treatmentRecommend: kfuncMatchCommandHealthTreatmentRecommendList(2, "13.0-1"),
        diseaseId: ["1"],
      ),
    ),
  },
};
