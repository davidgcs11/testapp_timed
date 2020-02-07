import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/pages/login/components/photo_card.dart';
import 'package:testtimed/providers/local/login_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginService(),
        )
      ],
      child: LoginPageBase(),
    );
  }
}

class LoginPageBase extends StatelessWidget {
  const LoginPageBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Crea tu usuario'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: loginService.usernameController,
              decoration: InputDecoration(
                hintText: 'Escribe tu nombre de usuario',
              ),
              validator: (input) => loginService.validateUsername(input: input)
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
              onTap: () => loginService.login(context),
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
                      'ACCEDER',
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
          )
        ],
      ),
    );
  }
}
