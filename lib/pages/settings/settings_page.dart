import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/pages/settings/components/photo_card.dart';
import 'package:testtimed/providers/local/settings_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => SettingService(context),
      )
    ], child: SettingsPageBase());
  }
}

class SettingsPageBase extends StatelessWidget {
  const SettingsPageBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingService settingService = Provider.of<SettingService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: settingService.usernameController,
              decoration: InputDecoration(
                hintText: 'Escribe tu nombre de usuario',
              ),
              validator: (input) =>
                  settingService.validateUsername(input: input)
                      ? null
                      : 'Tu usuario debe tener más de 5 caracteres',
              autovalidate: true,
            ),
          ),
          Text('ESCOGE TU AVATAR'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (var i = 0; i < Photo.values.length; i++)
                Expanded(
                  child: PhotoCard(
                    photoIndex: i,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => settingService.save(context),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'GUARDAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => settingService.logout(context),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'CERRAR SESIÓN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
