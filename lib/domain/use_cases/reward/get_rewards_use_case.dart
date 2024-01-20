import 'package:flutter_steps_tracker/driven/models/reward_model.dart';
import 'package:flutter_steps_tracker/domain/use_cases/use_case.dart';
import 'package:flutter_steps_tracker/domain/repositories/bottom_navbar_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRewardsUseCase extends UseCase<Stream<List<RewardModel>>, NoParams> {
  final BottomNavbarRepository _bottomNavbarRepository;

  GetRewardsUseCase(this._bottomNavbarRepository);

  @override
  Stream<List<RewardModel>> call(NoParams params) =>
      _bottomNavbarRepository.rewardsStream();
}
