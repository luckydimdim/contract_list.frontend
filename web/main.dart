import 'dart:core';

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/router.dart';
import 'package:angular2/src/platform/browser/location/hash_location_strategy.dart';
import 'package:angular2/platform/common.dart';

import 'package:alert/alert_service.dart';

import 'package:contract_list/contract_list_component.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:master_layout/master_layout_component.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

@Component(selector: 'app')
@View(
  template: '<master-layout><contract-list></contract-list></master-layout>',
  directives: const [MasterLayoutComponent, ContractListComponent])
class AppComponent {}

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }

  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(ResourcesLoaderService),
    const Provider(AlertService)]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}