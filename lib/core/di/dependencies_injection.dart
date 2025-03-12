import 'package:get_it/get_it.dart';

import 'data_module.dart';
import 'domain_module.dart';
import 'presentation_module.dart';

abstract class DependenciesInjection {
  GetIt get getIt;
  Future<void> init();
}

class DependenciesInjectionImpl extends DependenciesInjection {
  final GetIt _getIt = GetIt.instance;

  @override
  GetIt get getIt => _getIt;

  @override
  Future<void> init() async {
    await _setupDependencies();
  }

  Future<void> _setupDependencies() async {
    DataModule.register(_getIt);
    DomainModule.register(_getIt);
    PresentationModule.register(_getIt);
  }
}
