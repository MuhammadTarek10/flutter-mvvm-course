import 'package:stores/data/data_source/remote_data_source.dart';
import 'package:stores/data/mapper/mapper.dart';
import 'package:stores/data/network/error_handler.dart';
import 'package:stores/data/network/network_info.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:stores/domain/repository/repository.dart';

class RepositoryImp implements Reposotiry {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImp(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown,
            ),
          );
        }
      } catch (error) {
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    } else {
      return Left(
        DataSource.noIntentConnection.getFailure(),
      );
    }
  }
}
