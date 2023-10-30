import 'package:fin_control/data/models/currency.dart';

class Utils {
  static String getFormattedDate(DateTime date) {
    return "${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}:${date.second}";
  }

  static String getFormattedCurrencyToSymbol(Currency currency) {
    return switch (currency) {
      Currency.eur => "€",
      Currency.usd => "\$",
      Currency.rub => "₽",
    };
  }

  static String getFormattedCurrency(Currency currency) {
    return switch (currency) {
      Currency.eur => "EUR",
      Currency.usd => "USD",
      Currency.rub => "RUB",
    };
  }
}
