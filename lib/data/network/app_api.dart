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

  @POST('/customers/register')
  Future<AuthenticationResponse> register(
    @Field('username') String username,
    @Field('coutry_mobile_code') String coutryMobileCode,
    @Field('mobile_number') String mobileNumber,
    @Field('email') String email,
    @Field('password') String password,
    @Field('profile_picture') String profilePicture,
  );

  @GET('/home')
  Future<HomeResponse> getHomeData();

  @GET('/storeDetails/1')
  Future<StoreDetailsDataResponse> getStoreDetails();
}
