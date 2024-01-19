import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _email = '';
  String? _password = '';
  String? _name = '';
  Map<String, dynamic> _age = {};
  String? _selectedDay = '1';
  String? _selectedMonth = '1';
  String? _selectedYear = '1970';
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

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
                  SizedBox(height: 20),
                  emailTextField(),
                  SizedBox(height: 20),
                  nameTextField(),
                  SizedBox(height: 20),
                  passwordTextField(),
                  SizedBox(height: 10),
                  ageChooser(),
                  SizedBox(height: 20),
                  signUpButton(context),
                  SizedBox(height: 10),
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color.fromARGB(255, 122, 122, 122),
                      const Color.fromARGB(255, 90, 89, 89)
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Icon(
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

  ageChooser() {
    var days = List<String>.generate(30, (int index) => (index + 1).toString());
    var months =
        List<String>.generate(12, (int index) => (index + 1).toString());
    var years =
        List<String>.generate(200, (int index) => (index + 1900).toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Birthday : '),
        Container(
          width: 80,
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: DropdownButton<String>(
            underline: SizedBox(),
            isExpanded: true,
            items: days.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            value: _selectedDay,
            onChanged: (newVal) {
              setState(() {
                _selectedDay = newVal;
                _age['day'] = newVal;
              });
            },
          ),
        ),
        Container(
          width: 80,
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: DropdownButton<String>(
            underline: SizedBox(),
            isExpanded: true,
            items: months.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            value: _selectedMonth,
            onChanged: (newVal) {
              setState(() {
                _selectedMonth = newVal;
                _age['month'] = newVal;
              });
            },
          ),
        ),
        Container(
          width: 120,
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: DropdownButton<String>(
            underline: SizedBox(),
            isExpanded: true,
            items: years.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            value: _selectedYear,
            onChanged: (newVal) {
              setState(() {
                _selectedYear = newVal;
                _age['year'] = newVal;
              });
            },
          ),
        ),
      ],
    );
  }

/////////////////////-Functions-/////////////////////////////
  _trySubmit(BuildContext ctx) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_email.toString() + _password.toString())));
      _submitAuthForm(_email!.trim(), _password!.trim(), ctx);
    }
  }

  void _submitAuthForm(
    String email,
    String password,
    BuildContext ctx,
  ) {}
}
