import 'package:stores/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/repository/repository.dart';
import 'package:stores/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase implements BaseUseCase<void, StoreDetails> {
  final Reposotiry _reposotiry;
  StoreDetailsUseCase(this._reposotiry);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await _reposotiry.getStoreDetails();
  }
}
