import 'package:diada/providers/auth_provider.dart';
import 'package:diada/services/diada_api.dart';
import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../depresion/depresion_splash_screen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const String id = 'auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(150, 150, 150, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.5, 1.0],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 180,
                    child: const Image(
                      image: AssetImage('images/proyecto-diada-logo.png'),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  String dropdownValue = 'Femenino';
  var storeProfileResult = {};

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      context
          .read<AuthState>()
          .signInWithEmailAndPassword(
              _authData['email']!,
              _authData['password']!,
              (e) => _showErrorDialog(
                  context, 'No se puede ingresar a la cuenta', e))
          .then((String firebaseId) {
        if (context.read<AuthState>().isAuth == true)
          Navigator.pushNamed(context, DepresionSplashScreen.id);
      });
    } else {
      context
          .read<AuthState>()
          .registerAccount(
              _authData['email']!,
              _authData['nombre']!,
              _authData['password']!,
              (e) =>
                  _showErrorDialog(context, 'No se puede crear la cuenta', e))
          .then((String firebaseId) {
        _authData['id_firebase'] = firebaseId;
        storeProfile();
        if (context.read<AuthState>().isAuth == true) {
          Navigator.pushNamed(context, DepresionSplashScreen.id);
        }
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void storeProfile() async {
    storeProfileResult = await DiadaModel().storeProfileById(_authData);
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 520 : 280,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 520 : 280),
        width: deviceSize.width * 0.85,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entre su nombre de cuenta';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['nombre'] = value!;
                    },
                  ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Correo electrónico'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (emailValid == false) {
                      return 'Correo electrónico inválido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Documento de identidad'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      bool docValid = RegExp(r"^[0-9]{6,15}$").hasMatch(value!);
                      if (docValid == false) {
                        return 'El documento de identidad no es válido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['document'] = value!;
                    },
                  ),
                if (_authMode == AuthMode.Signup)
                  DropdownButtonFormField(
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    value: dropdownValue,
                    items: <String>['Femenino', 'Masculino']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.length < 5) {
                      return 'La contraseña es muy corta';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: const InputDecoration(
                        labelText: 'Confirmar contraseña'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Las contraseñas no coinciden';
                            }
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                        _authMode == AuthMode.Login ? 'Entrar' : 'Registrarse'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: const StadiumBorder(),
                    ),
                  ),
                TextButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'No tengo cuenta' : 'Entrar'}'),
                  onPressed: _switchAuthMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
