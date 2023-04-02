import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/auth_service.dart';
import 'package:foody/pages/pages.dart';
import 'package:foody/widgets/button_continue_widget.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/social_widget.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({Key? key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final name = TextEditingController();
  final moblie = TextEditingController();
  final address = TextEditingController();

  final email = TextEditingController();
  final password = TextEditingController();
  final conform = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthService authService = AuthService();

  Future signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
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
                ContinueButtonWidget.base(label: 'Sign out', voidCallback: (){
                  signOut();
                  nextScreenRemove(context, SignInPage());
                }),
                SizedBox(height: 30,),
                SocialButtonWidget.base(),
              ],
            ),
          ),),
      ),
    );
  }
  TextFormField nameTextFormField() {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }
  TextFormField addressTextFormField() {
    return TextFormField(
      controller: address,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.home_outlined),
      ),
    );
  }
  TextFormField mobileTextFormField() {
    return TextFormField(
      controller: moblie,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your moblie",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
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
      ),
      // validator: Utilities.vafidateEmail,
      onSaved: (value){
        setState(() {
          // email.text = value;
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
      ),
      // validator: Utilities.vafidateEmail,

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
      ),
      // validator: Utilities.vafidateEmail,
      onSaved: (value) {
        setState(() {
          // conform.text = value;
        });
      },
    );
  }
}