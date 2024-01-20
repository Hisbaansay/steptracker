class UserModel {
  final String uid;
  final String name;
  final int totalSteps;
  final int totalCalories;
  final int healthPoints;
  final String createdAt;

  UserModel({
    required this.uid,
    required this.name,
    this.totalSteps = 0,
    this.totalCalories = 0,
    this.healthPoints = 0,
    String? createdAt,
  }) : createdAt = createdAt ?? "${DateTime.now()}";

  factory UserModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return UserModel(
      uid: documentId,
      name: map['name'] as String,
      totalSteps: map['totalSteps'] as int,
      totalCalories: map['totalCalories'] as int,
      healthPoints: map['healthPoints'] as int,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'totalSteps': totalSteps,
      'totalCalories': totalCalories,
      'healthPoints': healthPoints,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    int? totalSteps,
    int? totalCalories,
    int? healthPoints,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      totalSteps: totalSteps ?? this.totalSteps,
      totalCalories: totalCalories ?? this.totalCalories,
      healthPoints: healthPoints ?? this.healthPoints,
      createdAt: this.createdAt, // Keep the original createdAt value
    );
  }
}
