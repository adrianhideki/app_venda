import 'package:flutter/material.dart';
import 'package:lolja/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final endController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
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
                  controller: nameController,
                  //keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Nome Completo",
                  ),
                  validator: (text) {
                    if (!text.isNotEmpty) return "Nome inválido!";
                    return null;
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
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: endController,
                  //keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Endereço",
                  ),
                  validator: (text) {
                    if (!text.isNotEmpty) return "Endereço inválido!";
                    return null;
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
                    color: Theme
                        .of(context)
                        .primaryColor,
                    onPressed: () {
                      Map<String, dynamic> userData = {
                        "name": nameController.text,
                        "email": emailController.text,
                        "address": endController.text,
                      };

                      if (_formKey.currentState.validate()) {
                        model.signUp(userData: userData,
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
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail() {

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Falha ao criar o usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );

  }
}
