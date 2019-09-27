import 'package:Pax/components/auth/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/auth/auth_input.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff454545),
        body: Stack(alignment: Alignment.center, children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 35, right: 35, left: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 80, left: 80),
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                  SizedBox(height: 70),
                  AuthInput(
                    labelText: "E-mail",
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 25),
                  AuthInput(
                    labelText: "Senha",
                    obscure: true,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AuthButton(
                    text: "Entrar",
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "RECUPERAR A SENHA",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "CRIE UMA CONTA",
                          style:
                              TextStyle(color: Color(0xff78aa43), fontSize: 12),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
