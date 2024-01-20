import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/design/cubits/auth_status/auth_status_cubit.dart';
import 'package:flutter_steps_tracker/design/cubits/auth_status/auth_status_state.dart';

import 'package:flutter_steps_tracker/design/screens/auth/auth_view.dart';
import 'package:flutter_steps_tracker/design/screens/bottom_nav_bar/bottom_navbar.dart';

class StepTrackerView extends StatelessWidget {
  const StepTrackerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthStatusCubit, AuthStatusState>(
      bloc: BlocProvider.of<AuthStatusCubit>(context),
      listener: (context, state) {
        if (state is Authenticated) {
          const BottomNavbar();
        } else {
          const AuthView();
        }
      },
      buildWhen: (previousState, currentState) => previousState != currentState,
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: () => const BottomNavbar(),
          unAuthenticated: () => const AuthView(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
