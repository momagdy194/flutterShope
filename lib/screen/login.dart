import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygeneralshope/customer/user.dart';
import 'package:mygeneralshope/screen/home_page.dart';
import 'package:mygeneralshope/screen/utilities/colorutilities.dart';
import '../api/authantication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();

  var _formKey = GlobalKey<FormState>();

  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * (0.3 / 2)),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Login to continue your account',
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 22)),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
                _loginform(context),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t Have an account?',
                    ),
                    FlatButton(onPressed: () {}, child: Text('Create Account'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginform(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Email Is reqierd';
              } else
                return null;
            },
            decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                hintText: 'Email'),
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Password Is reqierd';
              } else
                return null;
            },
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                hintText: 'Password'),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: RaisedButton(
              color: ScreenUtilities.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              onPressed:(_loading)?null:_loginUser,
              child: (_loading)
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white),
                    ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
//
        ],
      ),
    );
  }

  void _loginUser() async {

    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;
      User user = await authentication.login(email, password);
      if (user != null) {
        setState(() {
          _loading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        setState(() {
          _loading = false;
        });
      }    }




  }
}
