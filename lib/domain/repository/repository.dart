import 'package:dartz/dartz.dart';
import 'package:stores/data/network/failure.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/domain/models/models.dart';

abstract class Reposotiry {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
