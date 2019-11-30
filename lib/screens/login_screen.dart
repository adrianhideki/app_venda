import 'package:flutter/material.dart';
import 'package:lolja/models/user_model.dart';
import 'package:lolja/screens/singup_screen.dart';
import 'package:lolja/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
          builder: (context, child, model) {
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
                    validator: (text) {
                      if (!text.contains("@")) return "E-mail inválido!";
                      return null;
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
                    validator: (text) {
                      if (text.length < 6) return "Senha inválida!";
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if(emailController.text.isEmpty){
                          ShowSnackBar(_scaffoldKey, SnackBar(
                            content: Text("Informe o e-mail para a recuperação!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          model.recoverPass(emailController.text);
                          ShowSnackBar(_scaffoldKey, SnackBar(
                            content: Text("Confira seu e-mail!"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
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
                      color: Theme
                          .of(context)
                          .primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signIn(
                              email: emailController.text,
                              pass: passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
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

  void _onSuccess() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Falha ao tentar realizar o login!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}