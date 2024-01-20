import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_steps_tracker/lang/l10n.dart';
import 'package:flutter_steps_tracker/di/injection_container.dart';
import 'package:flutter_steps_tracker/routes/router.dart';
import 'package:flutter_steps_tracker/routes/routes.dart';
import 'package:flutter_steps_tracker/design/cubits/auth_status/auth_status_cubit.dart';
import 'package:flutter_steps_tracker/design/cubits/utility/utility_cubit.dart';
import 'package:flutter_steps_tracker/design/cubits/utility/utility_state.dart';
import 'package:flutter_steps_tracker/design/themes/theme_data.dart';

Future<void> main() async {
  await _initialize();
  runApp(const MyApp());
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configure();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UtilityCubit>(
          lazy: false,
          create: (BuildContext context) {
            final cubit = getIt<UtilityCubit>();
            cubit.getCurrentTheme();
            cubit.getCurrentLocale();
            return cubit;
          },
        ),
        BlocProvider<AuthStatusCubit>(
          lazy: false,
          create: (context) {
            final cubit = getIt<AuthStatusCubit>();
            cubit.checkAuthStatus();
            return cubit;
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: Builder(builder: (context) {
          final utility = BlocProvider.of<UtilityCubit>(context);
          return BlocBuilder<UtilityCubit, UtilityState>(
            bloc: utility,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Steps Tracker',
                theme: MainTheme.lightTheme(context),
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: utility.locale,
                themeMode: utility.currentTheme(),
                darkTheme: MainTheme.darkTheme(context),
                onGenerateRoute: onGenerate,
                initialRoute: AppRoutes.stepTrackerViewRoute,
              );
            },
          );
        }),
      ),
    );
  }
}
