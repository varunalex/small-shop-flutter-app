import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './../scoped_models/connected_models.dart';

import './../validation/validation.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  bool _acceptTerms = false;
  bool _isSubmited = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {'email': null, 'password': null};

  // DecorationImage _buildBackgroundImage() {
  //   return DecorationImage(
  //     fit: BoxFit.cover,
  //     colorFilter:
  //         ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
  //     image: AssetImage('assets/background.jpg'),
  //   );
  // }

  Widget _buildEmailTextField() {
    String label = 'E-mail';
    return TextFormField(
      decoration: InputDecoration(
          labelText: label, filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _formData['email'] = value;
      },
      autovalidate: _isSubmited ? true : false,
      validator: (String value) {
        return Validator(label: label, value: value, isEmail: true).validate();
      },
    );
  }

  Widget _buildPasswordTextField() {
    String label = 'Password';
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      onSaved: (String value) {
        _formData['password'] = value;
      },
      autovalidate: _isSubmited ? true : false,
      validator: (String value) {
        return Validator(label: label, value: value, min: 5).validate();
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function login) {
    if (!_formKey.currentState.validate() || !_acceptTerms) {
      setState(() {
        _isSubmited = true;
      });
      return;
    }
    _formKey.currentState.save();
    login(_formData['email'], _formData['password']);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.purple[400],
            Colors.purple[700],
            Colors.purple[800],
            Colors.purple[900]
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.5, 0.7, 0.8, 0.9],
        )
            // image: _buildBackgroundImage(),
            ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                width: targetWidth,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    _buildAcceptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<UsersModel>(
                      builder: (BuildContext context, Widget child,
                          UsersModel model) {
                        return RaisedButton(
                          textColor: Colors.white,
                          child: Text('LOGIN'),
                          onPressed: () => _submitForm(model.login),
                          color: Theme.of(context).accentColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
