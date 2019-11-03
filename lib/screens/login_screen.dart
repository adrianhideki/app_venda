import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(color: Colors.white),
            ),
            textColor: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "e-mail",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if (text.isEmpty || !text.contains("@")) return "E-mail inválido!";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "senha",
              ),
              obscureText: true,
              validator: (text){
                if (text.isEmpty || text.length < 6) return "Senha inválida!";
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Esqueci minha senha",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if(_formKey.currentState.validate()){

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
