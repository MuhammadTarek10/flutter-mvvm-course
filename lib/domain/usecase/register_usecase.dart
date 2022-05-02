import 'package:stores/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/data/response/responses.dart';
import 'package:stores/domain/repository/repository.dart';
import 'package:stores/domain/usecase/base_usecase.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<ForgetPasswordUseCaseInput, ForgetPasswordResponse> {
  final Reposotiry _reposotiry;
  ForgetPasswordUseCase(this._reposotiry);

  @override
  Future<Either<Failure, ForgetPasswordResponse>> execute(
      ForgetPasswordUseCaseInput input) async {
    return await _reposotiry.resetPassword(
      ResetPasswordRequest(
        input.email,
      ),
    );
  }
}

class ForgetPasswordUseCaseInput {
  String email;
  ForgetPasswordUseCaseInput(this.email);
}
