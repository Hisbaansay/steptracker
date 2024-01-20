class APIPath {
  //const API from firebase cloud store

  static String user(String uid) => 'users/$uid';
  static String users() => 'users/';
  static String rewards() => 'rewards/';

  static String myRewards(String uid) => 'users/$uid/rewards/';
  static String setMyReward(String uid, String id) => 'users/$uid/rewards/$id';

  static String dailyStepsAndPointsStream(String uid) =>
      'users/$uid/dailyPoints/';
  static String setDailyStepsAndPoints(String uid, String id) =>
      'users/$uid/dailyPoints/$id';

  static String exchangesHistory(String uid) => 'users/$uid/exchanges/';
  static String exchangeHistory(String uid, String exchangeId) =>
      'users/$uid/exchanges/$exchangeId';
}
