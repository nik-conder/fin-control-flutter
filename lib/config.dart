abstract class Config {}

class GeneralConfig extends Config {
  static const String appName = 'FinControl';
}

class ProfileLimits extends Config {
  static const int profileNameLimitChar = 32;
}
