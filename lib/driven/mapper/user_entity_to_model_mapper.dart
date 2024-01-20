import 'package:flutter_steps_tracker/driven/sources/local_data_sources/database.dart';
import 'package:flutter_steps_tracker/driven/models/user_model.dart';
import 'package:flutter_steps_tracker/domain/entities/user_entity.dart';

extension UserEntityToModelMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      uid: uid ?? documentIdFromLocalGenerator(),
      name: name,
    );
  }
}
