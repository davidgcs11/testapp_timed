import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/pages/dashboard/components/chat_message.dart';
import 'package:testtimed/pages/dashboard/components/message_row.dart';
import 'package:testtimed/providers/local/dashboard_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardService(context),
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
    String title = 'Recepción';
    if (dashboardService.numUsers != null) {
      title = 'Recepción (${dashboardService.numUsers})';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sentiment_very_satisfied),
            onPressed: () => dashboardService.openWebSocketsPage(),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => dashboardService.goToSettings(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('OTROS USUARIOS EN ESTE CHAT'),
                  ),
                ),
                for (User user in dashboardService.users)
                  ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(user.photoURL),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(user.username),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5,
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('MENSAJES'),
                  ),
                ),
                for (var i = 0; i < dashboardService.messages.length; i++)
                  ChatMessage(
                    message: dashboardService.messages[i],
                  ),
              ],
            ),
          ),
          MessageRow(),
        ],
      ),
    );
  }
}
