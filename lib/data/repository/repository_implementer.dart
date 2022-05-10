import 'package:stores/data/data_source/local_data_source.dart';
import 'package:stores/data/data_source/remote_data_source.dart';
import 'package:stores/data/mapper/mapper.dart';
import 'package:stores/data/network/error_handler.dart';
import 'package:stores/data/network/network_info.dart';
import 'package:stores/data/response/responses.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:stores/domain/repository/repository.dart';

class RepositoryImp implements Reposotiry {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImp(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

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

  @override
  Future<Either<Failure, ForgetPasswordResponse>> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.resetPassword(resetPasswordRequest);
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

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
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
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.notFound.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHome();

          if (response.status == ApiInternalStatus.success) {
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ApiInternalStatus.failure,
                response.message ?? ResponseMessage.unknown));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noIntentConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    try {
      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getStoreDetails();
          if (response.status == ApiInternalStatus.success) {
            _localDataSource.saveStoreDetailsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ApiInternalStatus.failure,
                response.message ?? ResponseMessage.unknown));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noIntentConnection.getFailure());
      }
    }
  }
}
