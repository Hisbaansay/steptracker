import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/common/error/failures/application_failure.dart';
import 'package:flutter_steps_tracker/domain/use_cases/use_case.dart';
import 'package:flutter_steps_tracker/domain/repositories/bottom_navbar_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetStepsAndPointsUseCase
    extends UseCase<Future<Either<Failure, bool>>, int> {
  final BottomNavbarRepository _bottomNavbarRepository;

  SetStepsAndPointsUseCase(this._bottomNavbarRepository);

  @override
  Future<Either<Failure, bool>> call(int params) async =>
      await _bottomNavbarRepository.setStepsAndPoints(params);
}
