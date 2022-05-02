import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stores/app/constants.dart';
import 'package:stores/data/response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST('/customers/resetPassword')
  Future<ForgetPasswordResponse> resetPassword(
    @Field('email') String email,
  );
}
