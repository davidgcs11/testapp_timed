import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/chat_models.dart';
import 'package:testtimed/providers/global/auth_service.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  const ChatMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    bool isFromTheUser = false;
    if (authService.user != null) {
      String usernameCreated = authService.user.username +
          '#' +
          authService.user.photo.index.toString();
      if (message.username == usernameCreated) {
        isFromTheUser = true;
      }
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 80,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: isFromTheUser ? 0 : null,
            left: isFromTheUser ? null : 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: isFromTheUser ? Colors.grey : Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(-1, -1),
                          blurRadius: 5,
                        )
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(
                                message.photoURL,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              message.username + ':',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(message.message),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
