import 'dart:async';

import 'package:stores/domain/usecase/register_usecase.dart';
import 'package:stores/presentation/base/base_view_model.dart';
import 'package:stores/presentation/common/freezed_data_classes.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/common/state_renderer/state_renderer.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  var forgetPasswordObject = ForgetPasswordObject("");
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  reset() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    (await _forgetPasswordUseCase.execute(
      ForgetPasswordUseCaseInput(
        forgetPasswordObject.email,
      ),
    ))
        .fold(
      (failure) => inputState.add(ErrorState(
        StateRendererType.popupErrorState,
        failure.message,
      )),
      (data) => inputState.add(ContentState()),
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    forgetPasswordObject = forgetPasswordObject.copyWith(email: email);
  }

  @override
  void start() {}

  @override
  dispose() {
    super.dispose();
    _emailStreamController.close();
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }
}

abstract class ForgetPasswordViewModelInputs {
  setEmail(String email);
  reset();

  Sink get inputEmail;
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get outEmailValid;
}
