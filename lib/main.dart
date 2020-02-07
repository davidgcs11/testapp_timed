import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/pages/dashboard/dashboard_page.dart';
import 'package:testtimed/pages/login/login_page.dart';
import 'package:testtimed/providers/global/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();

  @override
  void initState() {
    authService.initiateService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: authService,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BaseRouter(),
      ),
    );
  }
}

class BaseRouter extends StatefulWidget {
  const BaseRouter({Key key}) : super(key: key);

  @override
  _BaseRouterState createState() => _BaseRouterState();
}

class _BaseRouterState extends State<BaseRouter> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((val) => goToNextPage());
  }

  goToNextPage() {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    switch (authService.initialRoute) {
      case 'dashboard':
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
        break;
      default:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Cargando',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
