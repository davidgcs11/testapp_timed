import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/providers/local/dashboard_service.dart';

class MessageRow extends StatelessWidget {
  const MessageRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardService dashboardService = Provider.of<DashboardService>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: dashboardService.messageController,
          ),
        ),
        IconButton(
          onPressed: () => dashboardService.sendMessage(context),
          icon: Icon(Icons.send),
        )
      ],
    );
  }
}
