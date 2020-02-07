import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/providers/global/auth_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recepción'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () => authService.logout(),
          )
        ],
      ),
      body: Text('Dashboard'),
    );
  }
}
