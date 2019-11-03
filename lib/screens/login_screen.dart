import 'package:flutter/material.dart';
import 'package:lolja/models/user_model.dart';
import 'package:lolja/screens/singup_screen.dart';
import 'package:lolja/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

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
            onPressed: () {
              pageReplace(context, SingUpScreen());
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){

          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
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
                        model.signIn();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
