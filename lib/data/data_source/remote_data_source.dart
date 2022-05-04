import 'package:stores/data/network/app_api.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImp(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<ForgetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    return await _appServiceClient.resetPassword(
      resetPasswordRequest.email,
    );
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.username,
      registerRequest.countryMobileCode,
      registerRequest.mobileNumber,
      registerRequest.email,
      registerRequest.password,
      registerRequest.profilePicture,
    );
  }
}
