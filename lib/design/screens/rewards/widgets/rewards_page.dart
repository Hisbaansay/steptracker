import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/design/screens/rewards/widgets/rewards_item.dart';
import 'package:flutter_steps_tracker/driven/models/reward_model.dart';
import 'package:flutter_steps_tracker/di/injection_container.dart';
import 'package:flutter_steps_tracker/design/cubits/rewards/rewards_cubit.dart';
import 'package:flutter_steps_tracker/design/cubits/rewards/rewards_state.dart';
import 'package:flutter_steps_tracker/lang/l10n.dart';
import 'package:flutter_steps_tracker/common/constants/const_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RewardsCubit>(
      create: (_) {
        final cubit = getIt<RewardsCubit>();
        cubit.getRewards();
        return cubit;
      },
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  AppAssets.kRewards,
                  //fit: BoxFit.cover,
                  height: 250,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16.0),
                Text(
                  S.of(context).availableRewards,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 12.0),
                BlocBuilder<RewardsCubit, RewardsState>(
                  bloc: BlocProvider.of<RewardsCubit>(context),
                  builder: (_, state) {
                    return state.maybeWhen(
                      loaded: (rewards) =>
                          _buildList(context, rewards: rewards),
                      loading: () => _buildList(context, isLoading: true),
                      orElse: () => _buildList(context),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildList(BuildContext context,
      {bool isLoading = false, List<RewardModel>? rewards}) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    debugPrint('Rewards from the fun: ${rewards?.length}');
    return rewards != null && rewards.isNotEmpty
        ? Column(
            children: rewards
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: RewardsItem(reward: e),
                  ),
                )
                .toList(),
          )
        : Center(
            child: Text(
              S.current.emptyState,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
          );
  }
}
