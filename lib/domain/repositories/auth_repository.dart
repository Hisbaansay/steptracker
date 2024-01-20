import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/common/error/failures/application_failure.dart';
import 'package:flutter_steps_tracker/common/enums/enums.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signInAnonymously(String name);
  Future<AuthStatus> hasAnAccount();
}
