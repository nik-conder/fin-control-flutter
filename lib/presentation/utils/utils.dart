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

  static String hidePartOfToken(String token) {
    const visibleStart = 4;
    const visibleEnd = 4;
    const hiddenPartLength = 4;

    if (token.length <= visibleStart + visibleEnd) {
      final start = token.isNotEmpty ? token[0] : '';
      final end = token.length > 1 ? token[token.length - 1] : '';
      final hiddenPart = '*' * hiddenPartLength;

      return '$start$hiddenPart$end';
    }

    final start = token.substring(0, visibleStart);
    final end = token.substring(token.length - visibleEnd);
    final hiddenPart = '*' * hiddenPartLength;

    return '$start$hiddenPart$end';
  }
}
