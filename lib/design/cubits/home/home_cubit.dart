import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/driven/models/exchange_history_model.dart';
import 'package:flutter_steps_tracker/driven/sources/local_data_sources/database.dart';
import 'package:flutter_steps_tracker/domain/use_cases/board/get_user_data_use_case.dart';
import 'package:flutter_steps_tracker/domain/use_cases/exchange/set_exchange_history_use_case.dart';
import 'package:flutter_steps_tracker/domain/use_cases/home/set_steps_and_points_use_case.dart';
import 'package:flutter_steps_tracker/domain/use_cases/use_case.dart';
import 'package:flutter_steps_tracker/lang/l10n.dart';
import 'package:flutter_steps_tracker/common/enums/enums.dart';
import 'package:flutter_steps_tracker/design/cubits/home/home_state.dart';
import 'package:injectable/injectable.dart';
import 'package:pedometer/pedometer.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';


@injectable
class HomeCubit extends Cubit<HomeState> {
  final SetExchangeHistoryUseCase _setExchangeHistoryUseCase;
  final SetStepsAndPointsUseCase _setStepsAndPointsUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  late Stream<StepCount> _stepCountStream;
  int _initialStepCount = 0;

  HomeCubit(
      this._setExchangeHistoryUseCase,
      this._setStepsAndPointsUseCase,
      this._getUserDataUseCase,
      ) : super(
    const HomeState.initial(),
  );

  Future<void> initPlatformState() async {
    emit(const HomeState.loading());

    // Check for activity permission
    var status = await Permission.activityRecognition.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.activityRecognition.request();
      if (status != PermissionStatus.granted) {
        emit(HomeState.error(message: 'Something went wrong'));
        return;
      }
    }



    emit(const HomeState.loading());
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    // Fetch initial step count
    final initialStepCount = await _stepCountStream.first;
    debugPrint("khelo$_initialStepCount");
    _initialStepCount = initialStepCount?.steps ?? 0;}

  Future<void> getUserData() async {
    emit(const HomeState.stepsAndPointsLoading());
    final result = await _getUserDataUseCase(NoParams());
    result.fold(
          (failure) =>
          emit(HomeState.stepsError(message: 'Something went wrong')),
          (userData) => userData.listen(
            (event) {


          emit(
            HomeState.stepsAndPointsLoaded(
              steps: event.totalSteps,
              healthPoints: event.healthPoints,
            ),
          );
        },
      ),
    );
  }

  Future<void> onStepCount(StepCount event) async {
    debugPrint(event.toString());

    var adjustedSteps = event.steps - _initialStepCount;
    debugPrint("Adjusted Steps in Cubit: $adjustedSteps");
    emit(HomeState.loaded(steps: adjustedSteps.toString()));
    await _setStepsAndPointsUseCase(adjustedSteps);
    // ... (rest of the logic)
  }

  Future<void> onFeedbackState(int oldSteps, int newSteps) async {
    if ((oldSteps % 100) > (newSteps % 100)) {
      emit(HomeState.feedbackGain(steps: (newSteps - _initialStepCount).toString()));
      await _setExchangeHistoryUseCase(
        ExchangeHistoryModel(
          id: documentIdFromLocalGenerator(),
          title: ExchangeHistoryTitle.exchange.title,
          date: DateTime.now().toIso8601String(),
          points: 5,
        ),
      );
    }
  }

  void onStepCountError(error) {
    debugPrint('onStepCountError: $error');
    emit(HomeState.error(message: 'Error fetching step count'));
  }
}

