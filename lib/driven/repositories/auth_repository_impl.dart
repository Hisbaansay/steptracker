import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/driven/mapper/user_entity_to_model_mapper.dart';
import 'package:flutter_steps_tracker/driven/sources/local_data_sources/auth_local_data_source.dart';
import 'package:flutter_steps_tracker/driven/sources/remotly_data_source/auth_remote_data_source.dart';
import 'package:flutter_steps_tracker/driven/sources/local_data_sources/database.dart';
import 'package:flutter_steps_tracker/common/error/exceptions/application_exception.dart';
import 'package:flutter_steps_tracker/common/error/failures/application_failure.dart';
import 'package:flutter_steps_tracker/domain/entities/user_entity.dart';
import 'package:flutter_steps_tracker/domain/repositories/auth_repository.dart';
import 'package:flutter_steps_tracker/common/enums/enums.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final Database _database;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._database,
  );

  @override
  Future<Either<Failure, bool>> signInAnonymously(String name) async {
    try {
      final user = await _authRemoteDataSource.signInAnonymously();
      final newUser = UserEntity(
        name: name,
        uid: user?.uid,
      );
      await _authLocalDataSource.persistAuth(newUser.toModel());
      await _database.setUserData(newUser.toModel());
      return const Right(true);
    } on ApplicationException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<AuthStatus> hasAnAccount() async {
    final currentUser = await _authLocalDataSource.currentUser();
    if (currentUser != null) {
      return AuthStatus.authenticated;
    }
    return AuthStatus.unAuthenticated;
  }
}
