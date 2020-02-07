import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/providers/local/dashboard_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardService(),
        )
      ],
      child: DashboardPageBase(),
    );
  }
}

class DashboardPageBase extends StatelessWidget {
  const DashboardPageBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardService dashboardService = Provider.of<DashboardService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recepción'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => dashboardService.goToSettings(context),
          )
        ],
      ),
      body: Text('Dashboard'),
    );
  }
}
