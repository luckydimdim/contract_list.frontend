import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:alert/alert_service.dart';

import 'package:grid/grid.dart';

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

  ContractListComponent(this._router, this._alertService) {}

  @override
  void ngOnInit() {
    var model = new DataSourceSchemaModelWithFieldsArray();
    model.fields = new List<DataSourceSchemaModelField>();

    model.fields.add(
        new DataSourceSchemaModelField(field: "conclusionDate", type: "date"));

    var schema = new DataSourceSchema()..model = model;

    var transportRead = new DataSourceTransportRead()
      ..type = "get"
      ..dataType = "json"
      ..url = "//localhost:5000/api/contract";

    var transport = new DataSourceTransport()..read = transportRead;

    var dataSource = new DataSource()
      ..type = "odata"
      ..schema = schema
      ..transport = transport;

    GridOptions options = new GridOptions()
      ..dataSource = dataSource
      ..columns = new List<GridColumn>()
      ..filterable = true
      //..height = 500
      ..sortable = true;

    options.columns.add(new GridColumn(
        field: "number", title: "№", width: 150, filterable: true));
    options.columns.add(new GridColumn(
        field: "name", title: "Наименование договора", sortable: true));
    options.columns.add(new GridColumn(
        field: "conclusionDate",
        title: "Дата заключения",
        sortable: true,
        format: "{0: MM/dd/yyyy}"));

    new Grid("#grid", options);
  }
}
