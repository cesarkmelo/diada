import 'package:diada/providers/user_provider.dart';
import 'package:diada/utils/constants.dart';
import 'package:diada/widgets/autenticacion_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // new

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                child: Image(
                  image: AssetImage('images/proyecto-diada-logo.png'),
                ),
              ),
              Center(
                child: Consumer<UserState>(
                  builder: (context, appState, _) => Authentication(
                    email: appState.email,
                    loginState: appState.loginState,
                    startLoginFlow: appState.startLoginFlow,
                    verifyEmail: appState.verifyEmail,
                    signInWithEmailAndPassword:
                        appState.signInWithEmailAndPassword,
                    cancelRegistration: appState.cancelRegistration,
                    registerAccount: appState.registerAccount,
                    showResetPassword: appState.showResetPassword,
                    resetPassword: appState.resetPassword,
                    signOut: appState.signOut,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO Sacar base de datos de aplicacion vieja
//TODO Hacer sistema de consulta por cedula aplicacion vieja
//TODO Guardar datos de calculadora
