import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

/*
logger.t("Trace log");
logger.d("Debug log");
logger.i("Info log");
logger.w("Warning log");
logger.e("Error log", error: 'Test Error');
logger.f("What a fatal log", error: error, stackTrace: stackTrace);
*/
