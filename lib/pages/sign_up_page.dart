import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody/widgets/button_continue_widget.dart';
import 'package:foody/widgets/navigator_widget.dart';
import '../widgets/social_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 1,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
        centerTitle: true,
        title: Text("Sign up",style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Register Account",style: TextStyle(fontSize: 28, color: Colors.green,fontWeight: FontWeight.bold),),
                SizedBox(height: 1.5,),
                Text("Complete your details or continue \n with social media",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF4caf50)),),
                SizedBox(height: 24,),
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final email = TextEditingController();
  final password = TextEditingController();
  final conform = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  bool isEmailValidation = true;
  bool isPWValidation = true;
  bool isConPassValidation = true;

  String id = "";

  Future<void> register() async{
    if(isEmailValidation && isPWValidation && isConPassValidation){
      if(password.text == conform.text){
        try{
          await firebaseAuth.createUserWithEmailAndPassword(email: email.text, password: password.text)
              .then((value){
            setState(() {
              id = value.user!.uid;
            });
          });

          Map<String, dynamic> map ={
            'userID' : id,
            'email': email.text,
            'password': password.text,
          };

          FirebaseFirestore.instance.collection('users').doc(map['userID']).set(map).then((value){
            showSnackBar(context, Colors.green, "Register successfully");
            Navigator.pop(context);
          });
          Navigator.pop(context);
        } on FirebaseAuthException catch(e){
          showSnackBar(context, Colors.red, e.message.toString());
        }
      }else{
        showSnackBar(context, Colors.red, "Password does not match");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            emailTextFormField(),
            SizedBox(height: 30,),
            passwordTextFormField(),
            SizedBox(height: 30,),
            conformTextFormField(),
            SizedBox(height: 30,),
            ContinueButtonWidget.base(
                label: 'Continue',
                voidCallback: () {
                  register();
            }),
            SizedBox(height: 30,),
            SocialButtonWidget.base(),
          ],
        ),
      ),);
  }
  TextFormField emailTextFormField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email_outlined),
        errorText: !isEmailValidation ? "Please check your email!" :null,
      ),

      onChanged: (text){
        setState(() {
          isEmailValidation = validateEmail(email.text);
        });
      },
    );
  }
  TextFormField passwordTextFormField() {
    return TextFormField(
      key: _passKey,
      controller: password,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
        errorText: !isPWValidation ? "Please check your password!" : null,
      ),
      onChanged: (text){
        setState(() {
          isPWValidation = validatePassword(password.text);
        });
      },
    );
  }
  TextFormField conformTextFormField() {
    return TextFormField(
      controller: conform,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
        errorText: !isConPassValidation ? "Please check your confirm password!" : null,
      ),
      onChanged: (text){
        setState(() {
          isConPassValidation = conformPassword(password.text, conform.text);
        });
      },
    );
  }
}