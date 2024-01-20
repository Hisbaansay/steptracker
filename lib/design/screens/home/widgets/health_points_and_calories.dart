import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/common/constants/const_color.dart';
import 'package:flutter_steps_tracker/design/cubits/home/home_cubit.dart';
import 'package:flutter_steps_tracker/design/cubits/home/home_state.dart';
import 'package:flutter_steps_tracker/design/screens/home/widgets/health_points_and_calories_item.dart';
import 'package:flutter_steps_tracker/lang/l10n.dart';

class HealthPointsAndCalories extends StatelessWidget {
  const HealthPointsAndCalories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        return state.maybeWhen(
          stepsAndPointsLoading: () =>
              _buildHealthRow(context, isLoading: true),
          stepsAndPointsLoaded: (steps, healthPoints) => _buildHealthRow(
            context,
            steps: steps,
            healthPoints: healthPoints,
          ),
          orElse: () => _buildHealthRow(context),
        );
      },
    );
  }

  Widget _buildHealthRow(
    BuildContext context, {
    bool isLoading = false,
    int steps = 0,
    int? healthPoints,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: HealthPointsAndCaloriesItem(
            mainTitle: S.of(context).healthPoints,
            number: isLoading ? '-' : healthPoints.toString(),
            iconData: Icons.shopping_bag,
            color: Theme.of(context).primaryColor,
            unit: '',
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: HealthPointsAndCaloriesItem(
            mainTitle: S.of(context).totalSteps,
            number: isLoading ? '-' : steps.toString(),
            iconData: Icons.bubble_chart_rounded,
            color: AppColors.kTotalStepsColor,
          ),
        ),
      ],
    );
  }
}
