import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  bool _term = false;

  DecorationImage _buildBackgorundImage() {
    return DecorationImage(
      image: AssetImage('assets/background.jpg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.3),
        BlendMode.dstATop,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Widget _buildTermSwitch() {
    return SwitchListTile(
      onChanged: (bool value) {
        setState(() {
          _term = value;
        });
      },
      value: _term,
      title: Text('Accept Terms '),
    );
  }

  void _onSubmit() {
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgorundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              _buildEmailTextField(),
              _buildPasswordTextField(),
              _buildTermSwitch(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('SignIn'),
                color: Theme.of(context).accentColor,
                onPressed: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
