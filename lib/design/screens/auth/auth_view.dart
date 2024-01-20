import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/common/constants/const_color.dart';
import 'package:flutter_steps_tracker/di/injection_container.dart';
import 'package:flutter_steps_tracker/lang/l10n.dart';
import 'package:flutter_steps_tracker/common/constants/const_assets.dart';
import 'package:flutter_steps_tracker/design/cubits/auth_actions/auth_cubit.dart';
import 'package:flutter_steps_tracker/design/cubits/auth_actions/auth_state.dart';
import 'package:flutter_steps_tracker/design/cubits/auth_status/auth_status_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt<AuthCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            // appBar: AppBar(),
            body: Stack(
              children: [
                Image.asset(
                  AppAssets.kBackgroundIntro,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Opacity(
                    opacity: 0.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 48.0,
                    ),
                    child: Center(
                      child: BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          state.maybeWhen(
                              loggedIn: () {
                                final cubit =
                                    BlocProvider.of<AuthStatusCubit>(context);
                                cubit.checkAuthStatus();
                              },
                              orElse: () {});
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () => _buildColumn(true, context),
                            orElse: () => _buildColumn(false, context),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildColumn(bool isLoading, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          SvgPicture.asset(
            AppAssets.logo,
            color: AppColors.kLogoColor,
            height: 180,
            fit: BoxFit.cover,
          ),
          Text(
            S.of(context).allInOneTrack,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: AppColors.kBackgroundColor,
                  fontSize: 20,
                ),
          ),
          const Spacer(
            flex: 2,
          ),
          TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.kGreyColor,
            ),
            controller: _nameController,
            validator: (val) =>
                val!.isEmpty ? S.of(context).enterYourName : null,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: S.of(context).enterYourName,
            ),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                await BlocProvider.of<AuthCubit>(context).signInAnonymously(
                  name: _nameController.text,
                );
              }
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Center(
                child: !isLoading
                    ? Text(
                        S.of(context).startUsingSteps,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: AppColors.kBackgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
