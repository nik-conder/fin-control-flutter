import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/data/repository/session_repository.dart';
import 'package:fin_control/domain/bloc/account/account_bloc.dart';
import 'package:fin_control/domain/useCases/settings_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/settings_repository.dart';
import '../../data/repository/transactions_repository.dart';
import '../../domain/bloc/profile/profile_bloc.dart';
import '../../domain/bloc/session/session_bloc.dart';
import '../../domain/bloc/settings/settings_bloc.dart';
import '../../domain/bloc/theme/theme_bloc.dart';
import '../../domain/bloc/transactions/transactions_bloc.dart';

class PresentationModule {
  static void register(GetIt getIt) {
    // BloCs
    getIt.registerFactory<ThemeBloc>(
        () => ThemeBloc(getIt<SettingsRepository>()));

    getIt.registerFactory<ProfileBloc>(() =>
        ProfileBloc(getIt<SessionRepository>(), getIt<ProfilesRepository>()));

    getIt.registerFactory<SettingsBloc>(
        () => SettingsBloc(getIt<SettingsUseCase>()));

    getIt.registerFactory<SessionBloc>(() => SessionBloc());

    getIt.registerFactory<TransactionsBloc>(
        () => TransactionsBloc(getIt<TransactionsRepository>()));

    getIt.registerFactory<AccountBloc>(() => AccountBloc(getIt()));
  }
}
