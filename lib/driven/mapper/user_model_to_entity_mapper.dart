import 'package:flutter_steps_tracker/driven/models/user_model.dart';
import 'package:flutter_steps_tracker/domain/entities/leaderboard_item_entity.dart';

extension UserModelToMapper on List<UserModel> {
  List<LeaderboardItemEntity> toEntity() => map(
        (e) => LeaderboardItemEntity(
          uid: e.uid,
          name: e.name,
          stepsNumber: e.totalSteps,
          order: 0,
          healthPoints: e.healthPoints,
        ),
      ).toList();
}
