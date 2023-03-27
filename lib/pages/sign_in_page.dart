import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/auth_service.dart';
import 'package:foody/data/validate.dart';
import 'package:foody/pages/home_page.dart';
import 'package:foody/pages/sign_up_page.dart';
import 'package:foody/widgets/button_continue_widget.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/social_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerScreen(context),
              SignInForm(),
              footerScreen(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget headerScreen(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.2,
      alignment: Alignment.topRight,
      child: Image.asset("assets/images/dish.png"),
    );
  }
  Widget footerScreen(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomLeft,
      child: Image.asset("assets/images/dish_2.png"),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _value = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthService authService = AuthService();

  var prefs;
  final username = TextEditingController();
  final password = TextEditingController();
  final mapSharedPreference ='';

  @override
  void initState()  {
    super.initState();
    // _getData();

  }
  _getData() async{
    prefs = await SharedPreferences.getInstance();
    if(!prefs.getString('username').isEmpty()) {
      username.text = prefs.getString('username');
      password.text = prefs.getString('password');
      _value = prefs.getBool('check');
    };
  }

  login() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print('valid');
      await authService
          .login(username.text, password.text)
          .then((value) async {
        if(value==true){
          showSnackBar(context, Colors.green, "Sign in successfully");
          nextScreenRemove(context, HomePage());
        }
        else{
          showSnackBar(context, Colors.red, value);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Food Now", style: TextStyle(fontSize: 32, color: Colors.green,fontWeight: FontWeight.bold),),
              Text("Sign in with your email and password \n or continue with social media",
                style: TextStyle(color: Colors.green,),),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Username",
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                validator: (text){
                  print('email is validating');
                  return validateEmail(username.text);
                },
                onSaved: (value){
                  setState(() {
                    print('email is saved');
                    username.text = value!;
                  });
                },
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: password,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                ),
                validator: (text){
                  print('password is validating');
                  return validatePassword(password.text);
                },
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Checkbox(value: _value??true, onChanged: (value){
                    setState(() {
                      _value=value!;
                    });
                  }),
                  Text("Remember me", style: TextStyle(fontSize: 16, color: Colors.green),),
                ],
              ),
              ContinueButtonWidget.base(
                  label: 'Sign In',
                  voidCallback: () {
                    login();
              }),
              SizedBox(height: 5,),
              SocialButtonWidget.base(),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?", style: TextStyle(color: Colors.green, fontSize: 14),),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      nextScreen(context, SignUpPage());
                    },
                    child: Text("Sign Up",style: TextStyle(color: Colors.redAccent, fontSize: 14),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],),
    ));
  }
}