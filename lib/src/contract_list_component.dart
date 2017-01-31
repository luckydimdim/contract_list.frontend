import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:alert/alert_service.dart';
import 'package:resources_loader/resources_loader.dart';

@Component(selector: 'contract-list')
@View(
    templateUrl: 'contract_list_component.html', directives: const [RouterLink])
class ContractListComponent implements OnInit {
  static const String route_name = "ContractList";
  static const String route_path = "contractList";
  static const Route route = const Route(
      path: ContractListComponent.route_path,
      component: ContractListComponent,
      name: ContractListComponent.route_name);

  final Router _router;
  final AlertService _alertService;
  final ResourcesLoaderService _resourcesLoaderService;


  ContractListComponent(
      this._router, this._alertService, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    var table = querySelector('[table-click]') as TableElement;
    table.rows.forEach((TableRowElement row) {
      row.onClick.listen((MouseEvent e) {
        var currentRow = e.currentTarget as TableRowElement;
        String link = currentRow.getAttribute('data-href');

        print(link);

        _router.parent.navigateByUrl(link);
      });
    });
  }
}
