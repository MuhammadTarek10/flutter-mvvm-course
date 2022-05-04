import 'package:stores/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/repository/repository.dart';
import 'package:stores/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Reposotiry _reposotiry;
  HomeUseCase(this._reposotiry);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _reposotiry.getHome();
  }
}
