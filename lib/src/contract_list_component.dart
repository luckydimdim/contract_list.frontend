import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:alert/alert_service.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:grid/grid.dart';

@Component(selector: 'contract-list')
@View(
    templateUrl: 'contract_list_component.html', directives: const [RouterLink])
class ContractListComponent implements OnInit, OnDestroy {
  static const String route_name = "ContractList";
  static const String route_path = "contractList";
  static const Route route = const Route(
      path: ContractListComponent.route_path,
      component: ContractListComponent,
      name: ContractListComponent.route_name);

  final Router _router;
  final AlertService _alertService;
  final ResourcesLoaderService _resourcesLoaderService;

  Grid _grid;

  ContractListComponent(this._router, this._alertService, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {


    var columns = new List<Column>();
    columns.add(new Column(field: 'number', caption: '№', size: '150px'));
    columns.add(new Column(field: 'name', caption: 'Наименование договора', size: '300px'));
    columns.add(new Column(field: 'conclusionDate', caption: 'Дата заключения', size: '150px', render: 'date'));

    GridOptions options = new GridOptions()
      ..name = 'grid'
      ..columns = columns
      ..url='//cm-ylng-msk-01/cmas-backend/api/contract'
      ..method='GET';
/*
    options.columns.add(new GridColumn(
        field: "number", title: "№", width: 150, filterable: true));
    options.columns.add(new GridColumn(
        field: "name", title: "Наименование договора", sortable: true));
    options.columns.add(new GridColumn(
        field: "conclusionDate",
        title: "Дата заключения",
        sortable: true,
        format: "{0: MM/dd/yyyy}"));
*/

    _grid = new Grid(this._resourcesLoaderService, "#grid", options);
  }

  @override
  void ngOnDestroy() {
    _grid.Destroy();

  }
}
