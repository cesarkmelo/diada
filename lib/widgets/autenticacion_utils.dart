import 'package:diada/providers/user_provider.dart';
import 'package:diada/screens/about/about_screen.dart';
import 'package:diada/screens/intro/intro_screen.dart';
import 'package:diada/screens/resultados/resultados_tabla_screen.dart';
import 'package:diada/services/diada_api.dart';
import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/alcoholismo/alhoholismo_screen.dart';
import '../screens/ansiedad/ansiedad_splash_screen.dart';
import '../screens/depresion/depresion_screen.dart';
import '../screens/depresion/depresion_splash_screen.dart';
import 'main_menu_item.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
  resetPassword,
  showResetPassword
}

class Authentication extends StatelessWidget {
  static const String id = 'autenticacion_screen';
  const Authentication({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.showResetPassword,
    required this.registerAccount,
    required this.signOut,
    required this.resetPassword,
  });

  final ApplicationLoginState loginState;
  final String email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final Function() showResetPassword;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) resetPassword;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Text(
                'Bienvenido, aun no tenemos sus datos por favor, haga click en continuar para entrar a la aplicación o registrarse si aun no lo ha hecho.',
                style: kQuestionTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 100,
              ),
              StyledButton(
                onPressed: () {
                  startLoginFlow();
                },
                child: const Text('Continuar'),
              ),
            ],
          ),
        );
      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Correo invalido', e)));
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Error al entrar', e));
          },
          showResetPassword: () {
            showResetPassword();
          },
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          email: email,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                password,
                (e) =>
                    _showErrorDialog(context, 'No se pudo crear la cuenta', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        String firebaseId = context.read<UserState>().uid;
        String userName = context.read<UserState>().uname;
        Future<dynamic> userDocid() async {
          return await DiadaModel().getAnyFieldById(firebaseId, 'cedula');
        }

        return FutureBuilder(
          future: userDocid(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    Text(
                      'Bienvenido $userName',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    const Text(
                      '¿Qué desea hacer?',
                      style: kLoginTextStyle,
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    MainMenuItem(
                      title: 'Ansiedad',
                      icon: Icons.add,
                      onTap: () {
                        Navigator.pushNamed(context, AnsiedadSplashScreen.id);
                      },
                    ),
                    MainMenuItem(
                      title: 'Tomar el cuestionario',
                      icon: Icons.add,
                      onTap: () {
                        Navigator.pushNamed(context, DepresionSplashScreen.id);
                      },
                    ),
                    MainMenuItem(
                      title: 'Ver resultados anteriores',
                      icon: Icons.bar_chart,
                      onTap: () {
                        Navigator.pushNamed(context, ResultadosTablaScreen.id);
                      },
                    ),
                    MainMenuItem(
                      title: 'Conocer el proyecto',
                      icon: Icons.article,
                      onTap: () {
                        Navigator.pushNamed(context, AboutScreen.id);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<UserState>().signOut();
                        depresionBrain.reset();
                        alcoholismoBrain.reset();
                        Navigator.pushNamed(context, IntroScreen.id);
                      },
                      child: const Text(
                        'Salir',
                        style: kLoginTextStyle,
                      ),
                    ),
                  ],
                );
              } else
                return DiadaForm(
                  callback: (cedula, genero) {
                    Map<String, String> body = {};
                    body['id_firebase'] = firebaseId;
                    body['nombre'] = context.read<UserState>().uname;
                    body['cedula'] = cedula;
                    body['genero'] = genero;
                    body['add'] = '';
                    dynamic storeResult = DiadaModel().storeProfileById(body);
                    Navigator.pushNamed(context, DepresionSplashScreen.id);
                  },
                );
            } else
              return Container(
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator());
          },
        );
      case ApplicationLoginState.resetPassword:
        return ResetForm(
          email: email,
          callback: (email) {
            resetPassword(
              email,
              (e) => _showErrorDialog(context, 'Correo invalido', e),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Mensaje enviado, revise su correo.'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        );
      default:
        return const Row(
          children: [
            Text("Eror interno, esto no debe pasar..."),
          ],
        );
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
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  /*void _storeResult(body) async {
    setProfileResult = await DiadaModel().storeProfileById(body);
  }*/
}

class DiadaForm extends StatefulWidget {
  const DiadaForm({required this.callback});
  final void Function(String genero, String cedula) callback;

  @override
  _DiadaFormState createState() => _DiadaFormState();
}

class _DiadaFormState extends State<DiadaForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_DiadaFormState');
  final _idController = TextEditingController();
  String dropdownValue = 'Femenino';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Por favor digite su documento de identidad y genero',
            textAlign: TextAlign.center,
            style: kLoginTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _idController,
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
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.callback(
                              _idController.text,
                              dropdownValue,
                            );
                          }
                        },
                        child: const Text('Finalizar registro'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback});
  final void Function(String email) callback;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Por favor digite su correo electrónico'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    style: kLoginTextStyle,
                    controller: _controller,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Correo electrónico',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite su correo electrónico para continuar';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: StyledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.callback(_controller.text);
                          }
                        },
                        child: const Text('Siguiente'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ResetForm extends StatefulWidget {
  const ResetForm({required this.email, required this.callback});
  final String email;
  final void Function(String email) callback;
  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ResetFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.email;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Header(
              'Digite el correo electrónico registrado en su cuenta, le enviaremos un mensaje para que pueda cambiar su contraseña'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: kLoginTextStyle,
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Correo electrónico',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite su correo electrónico para continuar';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: StyledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.callback(_controller.text);
                          }
                        },
                        child: const Text('RECIBIR MENSAJE'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.registerAccount,
    required this.cancel,
    required this.email,
  });
  final String email;
  final void Function(String email, String displayName, String password)
      registerAccount;
  final void Function() cancel;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Crear cuenta'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    style: const TextStyle(color: kTextColor),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Entre su correo electrónico',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entre su correo electrónico para continuar';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    style: const TextStyle(color: kTextColor),
                    textCapitalization: TextCapitalization.words,
                    controller: _displayNameController,
                    decoration: const InputDecoration(
                      hintText: 'Nombre completo',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entre su nombre de cuenta';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    style: const TextStyle(color: kTextColor),
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entre su contraseña';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: widget.cancel,
                        child: const Text('CANCELAR'),
                      ),
                      const SizedBox(width: 16),
                      StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.registerAccount(
                              _emailController.text,
                              _displayNameController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text('GUARDAR'),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    required this.login,
    required this.email,
    required this.showResetPassword,
  });
  final String email;
  final void Function(String email, String password) login;
  final Function() showResetPassword;
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Por favor digite su contraseña'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: kTextColor),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Entre su correo electrónico',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite su correo electrónico para continuar';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: kTextColor),
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entre su contraseña';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16),
                      StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text('Entrar'),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      widget.showResetPassword();
                    },
                    child: Text(
                      'Olvide mi contraseña',
                      style: kLoginTextStyle.copyWith(
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 2,
          backgroundColor: kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: onPressed,
        child: child,
      );
}

class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: kLoginTextStyle,
        ),
      );
}
