import 'package:flutter/material.dart';

class SingUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: nameController,
              //keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Nome Completo",
              ),
              validator: (text){
                if (!text.isNotEmpty) return "Nome inválido!";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: emailController,
              //keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "e-mail",
              ),
              validator: (text){
                if (!text.contains("@")) return "E-mail inválido!";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: passController,
              //keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "senha",
              ),
              obscureText: true,
              validator: (text){
                if (text.length < 6) return "Senha inválida!";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: endController,
              //keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Endereço",
              ),
              validator: (text){
                if (!text.isNotEmpty) return "Endereço inválido!";
              },
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text(
                  "Criar Conta",
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
