import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/common/error/failures/application_failure.dart';
import 'package:flutter_steps_tracker/driven/models/exchange_history_model.dart';
import 'package:flutter_steps_tracker/domain/use_cases/use_case.dart';
import 'package:flutter_steps_tracker/domain/repositories/bottom_navbar_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHistoryExchangesUseCase extends UseCase<
    Future<Either<Failure, Stream<List<ExchangeHistoryModel>>>>, NoParams> {
  final BottomNavbarRepository _bottomNavbarRepository;

  GetHistoryExchangesUseCase(this._bottomNavbarRepository);

  @override
  Future<Either<Failure, Stream<List<ExchangeHistoryModel>>>> call(
          NoParams params) async =>
      await _bottomNavbarRepository.exchangesHistoryStream();
}
