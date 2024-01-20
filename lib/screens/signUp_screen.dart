import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _email = '';
  String? _password = '';
  String? _name = '';
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              color: Colors.blue,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Center(
          child: SingleChildScrollView(
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
                  const SizedBox(height: 20),
                  emailTextField(),
                  const SizedBox(height: 20),
                  nameTextField(),
                  const SizedBox(height: 20),
                  passwordTextField(),
                  const SizedBox(height: 10),
                  signUpButton(context),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ))),
    );
  }

/////////////////////-Widgets-/////////////////////////////
  headerText() {
    return Text('Sign Up',
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
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_nameFocusNode);
      },
    );
  }

  nameTextField() {
    return TextFormField(
      key: ValueKey('name'),
      focusNode: _nameFocusNode,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter valid name';
        }
        return null;
      },
      onSaved: (newValue) {
        _name = newValue;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  passwordTextField() {
    return TextFormField(
      key: ValueKey('logintype'),
      focusNode: _passwordFocusNode,
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
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  signUpButton(BuildContext ctx) {
    return InkWell(
      onTap: () async {
        await _trySubmit(ctx);
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
                      Color.fromARGB(255, 122, 122, 122),
                      Color.fromARGB(255, 90, 89, 89)
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
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )),
          ),
          const Positioned(
            right: 120,
            top: 13,
            child: Text(
              'Sign Up',
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

/////////////////////-Functions-/////////////////////////////
  _trySubmit(BuildContext ctx) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              _email.toString() + _password.toString() + _name.toString())));
      _submitAuthForm(_email!.trim(), _password!.trim(), ctx);
    }
  }

  void _submitAuthForm(
    String email,
    String password,
    BuildContext ctx,
  ) {}
}
