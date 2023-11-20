class GeneralConfig {
  static const String appName = 'FinControl';
}

class ProfileLimits {
  static const int maxNameLimitChar = 32;
  static const int minNameLimitChar = 3;
}

class TransactionsLimits {
  static const int maxAmount = 1000000;
  static const int minAmount = 0;
  static const int pageSize = 20;
  static const int maxAmountChar = 12;
  static const int maxNoteChar = 64;
}