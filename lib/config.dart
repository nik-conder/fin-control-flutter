abstract class Config {}

class GeneralConfig extends Config {
  static const String appName = 'FinControl';
}

class ProfileLimits extends Config {
  static const int maxNameLimitChar = 32;
  static const int minNameLimitChar = 3;
}

class TransactionsLimits extends Config {
  static const int maxAmount = 1000000;
  static const int minAmount = 0;
  static const int pageSize = 20;
}
