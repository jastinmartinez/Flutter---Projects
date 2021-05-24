import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/auth.dart';
import 'package:recruitment_app/Models/user.dart';
import 'package:recruitment_app/Widgets/Others/exception_handler.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = new GlobalKey<FormState>();
  final _emailController = new TextEditingController();
  final _userController = new TextEditingController();
  final _passwordController = new TextEditingController();
  bool _isRegisterMode = false;

  Future<void> _trySubmit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final _auth = Provider.of<Auth>(context, listen: false);
      final _user = Provider.of<User>(context, listen: false);

      if (_isRegisterMode) {
        await _auth
            .registerWithEmailAndPassword(
          new Auth(
            email: _emailController.text,
            passoword: _passwordController.text,
          ),
        )
            .then((_) async {
          if (_auth.authResult != null) {
            await _user.addAplicantUser(
              new User(
                id: _auth.authResult.user.uid,
                name: _userController.text,
                email: _emailController.text,
                audit: {
                  'createdBy': _auth.authResult.user.uid,
                  'createdAt': DateTime.now(),
                  'modifiedBy': null,
                  'modifiedAt': null,
                },
              ),
            );
          }
        }).catchError(
          (loginError) {
            ExceptionHandler.erroSnackBar(context, loginError);
          },
        ).timeout(Duration(seconds: 30),
                onTimeout: () async =>
                    await ExceptionHandler.timeOutSnackBar(context));
      } else {
        await _auth
            .signInWithEmailAndPassword(
          new Auth(
            email: _emailController.text,
            passoword: _passwordController.text,
          ),
        )
            .whenComplete(() async {
          await _user.fetchUser();
        }).catchError(
          (registerError) {
            ExceptionHandler.erroSnackBar(context, registerError);
          },
        ).timeout(Duration(seconds: 30),
                onTimeout: () async =>
                    await ExceptionHandler.timeOutSnackBar(context));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _userController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Reclutamiento',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Seleccion',
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              CircleAvatar(
                radius: 50,
                child: SvgPicture.asset(
                  'assets/icons/owl.svg',
                  height: 100,
                  width: 100,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Correo',
                ),
                controller: _emailController,
                validator: (email) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email);
                  if (email.isEmpty) {
                    return 'Digite correo';
                  } else if (!emailValid) {
                    return 'Direccion de correo invalida';
                  }
                  return null;
                },
              ),
              if (_isRegisterMode)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                  ),
                  controller: _userController,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  validator: (user) {
                    if (user.isEmpty) {
                      return 'Digite el usuario';
                    } else if (user.length < 4) {
                      return 'El usuario debe tener minimo 4 digitos';
                    }
                    return null;
                  },
                ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (password) {
                  if (password.isEmpty) {
                    return 'Digitar Contraseña';
                  } else if (password.length < 6) {
                    return 'Muy Corta';
                  }
                  return null;
                },
              ),
              if (_isRegisterMode)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar Contraseña',
                  ),
                  obscureText: true,
                  validator: (password) {
                    if (password != _passwordController.text) {
                      return 'Contraseña no coinciden';
                    }
                    return null;
                  },
                ),
              SizedBox(
                height: 20,
              ),
              Text(
                _isRegisterMode == false
                    ? 'Registrarse'
                    : 'Ya tengo una cuenta',
                style: TextStyle(color: kBlueColor),
              ),
              Switch(
                value: _isRegisterMode,
                onChanged: (_) {
                  setState(
                    () {
                      _isRegisterMode = !_isRegisterMode;
                    },
                  );
                },
              ),
              FlatButton(
                color: kSecondaryColor,
                child: Text(_isRegisterMode ? 'Registrar' : 'Entrar'),
                onPressed: () async => await _trySubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
