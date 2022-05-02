import 'package:stores/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/repository/repository.dart';
import 'package:stores/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Reposotiry _reposotiry;
  LoginUseCase(this._reposotiry);

  @override
  Future<Either<Failure, Authentication>> execute(
    LoginUseCaseInput input,
  ) async {
    return await _reposotiry.login(
      LoginRequest(
        input.email,
        input.password,
      ),
    );
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
