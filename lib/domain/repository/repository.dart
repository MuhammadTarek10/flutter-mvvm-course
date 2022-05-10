import 'package:dartz/dartz.dart';
import 'package:stores/data/network/failure.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/data/response/responses.dart';
import 'package:stores/domain/models/models.dart';

abstract class Reposotiry {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgetPasswordResponse>> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
  Future<Either<Failure, StoreDetails>> getStoreDetails();
}
