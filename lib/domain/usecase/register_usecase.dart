import 'package:dartz/dartz.dart';
import 'package:stores/data/network/failure.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/repository/repository.dart';
import 'package:stores/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Reposotiry _reposotiry;
  RegisterUseCase(this._reposotiry);

  @override
  Future<Either<Failure, Authentication>> execute(
    RegisterUseCaseInput input,
  ) async {
    return await _reposotiry.register(
      RegisterRequest(
        input.username,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
        input.profilePicture,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String username;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
    this.username,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
