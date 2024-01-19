import 'package:flutter/material.dart';
import 'package:iotapp/screens/signUp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email = '';
  String? _password = '';
  bool _isLoading = false;

  final _passFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  _signOut() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login page")),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: Colors.grey[50],
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          headerText(),
                          SizedBox(height: 20),
                          emailTextField(),
                          SizedBox(height: 20),
                          passwordTextField(context),
                          SizedBox(height: 20),
                          signInButton(context),
                          SizedBox(height: 10),
                          bottomText(context),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  /////////////////////-Widgets-/////////////////////////////
  headerText() {
    return Text('Welcome',
        style: TextStyle(fontSize: 40, color: Colors.grey[500]));
  }

  emailTextField() {
    return TextFormField(
      key: ValueKey('email'),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'E-mail'),
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'please enter valid email address';
        }
        return null;
      },
      onSaved: (newValue) {
        _email = newValue;
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passFocusNode);
      },
    );
  }

  passwordTextField(BuildContext context) {
    return TextFormField(
      key: ValueKey('logintype'),
      focusNode: _passFocusNode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (value) {
        if (value!.isEmpty || value.length < 4) {
          return 'Please enter at least 4 characters';
        }
        return null;
      },
      onSaved: (newValue) {
        _password = newValue;
      },
      onFieldSubmitted: (_) {
        _trySubmit(context);
      },
    );
  }

  signInButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _trySubmit(context);
      },
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 50,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 106, 163, 219),
                      Color.fromARGB(255, 66, 169, 253)
                    ]),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
          ),
          Positioned(
            right: 10,
            top: 5,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Icon(Icons.arrow_forward)),
          ),
          const Positioned(
            right: 120,
            top: 13,
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }

  bottomText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Dont have account? ', style: TextStyle(fontSize: 15)),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ));
            },
            child: const Text('Sign up',
                style: TextStyle(fontSize: 18, color: Colors.blue)))
      ],
    );
  }

/////////////////////-Functions-/////////////////////////////
  void _trySubmit(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_email.toString() + _password.toString())));
    }
  }

  Future<void> _getUserIinformation() async {}
}
