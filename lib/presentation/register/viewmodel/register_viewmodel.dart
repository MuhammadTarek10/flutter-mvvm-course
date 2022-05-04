import 'dart:async';
import 'dart:io';

import 'package:stores/app/functions.dart';
import 'package:stores/domain/usecase/register_usecase.dart';
import 'package:stores/presentation/base/base_view_model.dart';
import 'package:stores/presentation/common/freezed_data_classes.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/common/state_renderer/state_renderer.dart';
import 'package:stores/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePicutreStreamController =
      StreamController<File>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _countryMobileCodeStreamController =
      StreamController<String>.broadcast();
  final StreamController _areInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserRegisteredSuccessfullyStreamController =
      StreamController<bool>();

  var registerObject = RegisterObject("", "", "", "", "", "");

  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _usernameStreamController.close();
    _passwordStreamController.close();
    _profilePicutreStreamController.close();
    _mobileNumberStreamController.close();
    _countryMobileCodeStreamController.close();
    _emailStreamController.close();
    _areInputsValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();
  }

  @override
  Sink get inputCountryMobileCode => _countryMobileCodeStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePicutreStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areInputsValidStreamController.sink;

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outCountryMobileCodeValid =>
      _countryMobileCodeStreamController.stream.map(
          (countryMobileCode) => _isCountryMobileCodeValid(countryMobileCode));

  @override
  Stream<bool> get outEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outMobileNumberValid => _mobileNumberStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<bool> get outPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<File> get outProfilePicture =>
      _profilePicutreStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<String?> get outErrorCountryMobileCode =>
      outCountryMobileCodeValid.map(
        (isCountryMobileCode) =>
            isCountryMobileCode ? null : AppStrings.errorCountryMobileCode,
      );

  @override
  Stream<String?> get outErrorEmail => outEmailValid.map(
        (isEmail) => isEmail ? null : AppStrings.errorEmail,
      );

  @override
  Stream<String?> get outErrorMobileNumber => outMobileNumberValid.map(
        (isMobileNumber) =>
            isMobileNumber ? null : AppStrings.errorMobileNumber,
      );

  @override
  Stream<String?> get outErrorPassword => outPasswordValid.map(
        (isPassword) => isPassword ? null : AppStrings.errorPassword,
      );

  @override
  Stream<String?> get outErrorUsername => outUsernameValid.map(
        (isUsername) => isUsername ? null : AppStrings.errorUsername,
      );

  @override
  register() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        registerObject.username,
        registerObject.countryMobileCode,
        registerObject.mobileNumber,
        registerObject.email,
        registerObject.password,
        registerObject.profilePicture,
      ),
    ))
        .fold(
      (failure) => inputState.add(ErrorState(
        StateRendererType.popupErrorState,
        failure.message,
      )),
      (data) {
        inputState.add(ContentState());
        isUserRegisteredSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  setCountryMobileCode(String countryMobileCode) {
    inputCountryMobileCode.add(countryMobileCode);
    if (_isCountryMobileCodeValid(countryMobileCode)) {
      registerObject =
          registerObject.copyWith(countryMobileCode: countryMobileCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    if (_isUsernameValid(username)) {
      registerObject = registerObject.copyWith(username: username);
    } else {
      registerObject = registerObject.copyWith(username: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (_isProfilePictureValid(profilePicture)) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  bool _isEmailValid(String email) {
    return isEmailValid(email);
  }

  bool _isUsernameValid(String username) {
    return username.length >= 6;
  }

  bool _isProfilePictureValid(File profilePicture) {
    return profilePicture.path.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.isNotEmpty;
  }

  bool _isCountryMobileCodeValid(String countryMobileCode) {
    return countryMobileCode.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.username.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAreAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  setCountryMobileCode(String countryMobileCode);
  setProfilePicture(File profilePicture);
  setEmail(String email);
  setMobileNumber(String mobileNumber);

  register();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputCountryMobileCode;
  Sink get inputProfilePicture;
  Sink get inputEmail;
  Sink get inputMobileNumber;
  Sink get inputAreAllInputsValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outUsernameValid;
  Stream<String?> get outErrorUsername;

  Stream<bool> get outPasswordValid;
  Stream<String?> get outErrorPassword;

  Stream<bool> get outCountryMobileCodeValid;
  Stream<String?> get outErrorCountryMobileCode;

  Stream<File> get outProfilePicture;

  Stream<bool> get outEmailValid;
  Stream<String?> get outErrorEmail;

  Stream<bool> get outMobileNumberValid;
  Stream<String?> get outErrorMobileNumber;

  Stream<bool> get outAreAllInputsValid;
}
