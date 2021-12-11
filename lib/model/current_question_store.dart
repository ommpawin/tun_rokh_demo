import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tun_rokh_demo/data/flowchart_process.dart';

class CurrentQuestionStore with ChangeNotifier {
  int _chartId = 0;
  String _frameId = "0.0";
  Widget _currentWidget = SizedBox();
  List<dynamic> _diagnoseTimeline = [];

  int get chartId => _chartId;
  String get frameId => _frameId;
  Widget get currentWidget => _currentWidget;
  List<dynamic> get diagnoseTimeline => _diagnoseTimeline;

  void intiCurrentWidget({required int chartId, String? frameId}) {
    _chartId = chartId;
    _frameId = frameId == null ? "1.0" : frameId;
    _currentWidget = mainFlowChart[_chartId][_frameId];
    _diagnoseTimeline = [
      {
        "historyType": "Question",
        "packageType": {
          "questionType": "StartPoint",
        }
      },
    ];
  }

  void clearCurrentWidget(bool type) {
    if (type == true) {
      _chartId = 0;
      _frameId = "0.0";
      _currentWidget = SizedBox();
      _diagnoseTimeline = [];
    }
  }

  void updateCurrentWidget({int? chartId, required String frameId, required Widget currentWidget}) {
    _chartId = chartId == null ? _chartId : chartId;
    _frameId = frameId;
    _currentWidget = currentWidget;
    notifyListeners();
  }

  void updateDiagnoseTimeline(Map<String, dynamic> diagnoseTimeline) {
    _diagnoseTimeline.insert(0, diagnoseTimeline);
  }

  void updataNotify() {
    notifyListeners();
  }
}
