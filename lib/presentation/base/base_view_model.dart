import 'dart:async';

import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';

abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // close view model

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);
}
