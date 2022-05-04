import 'dart:async';

import 'package:stores/app/functions.dart';
import 'package:stores/domain/usecase/login_usecase.dart';
import 'package:stores/presentation/base/base_view_model.dart';
import 'package:stores/presentation/common/freezed_data_classes.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/common/state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _usernameStreamController.close();
    _passwordStreamController.close();
    _areInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  // inputs
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    (await _loginUseCase.execute(
      LoginUseCaseInput(
        loginObject.username,
        loginObject.password,
      ),
    ))
        .fold(
            (failure) => inputState.add(ErrorState(
                  StateRendererType.popupErrorState,
                  failure.message,
                )), (data) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    inputAreAllInputsValid.add(null);
  }

  // outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map(
        (password) => _isPasswordValid(password),
      );

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outIsUsernameValid => _usernameStreamController.stream.map(
        (username) => _isUsernameValid(username),
      );

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return isEmailValid(username);
  }

  bool _areAllInputsValid() {
    return _isUsernameValid(loginObject.username) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;
}
