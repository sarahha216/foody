import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/auth_service.dart';
import 'package:foody/data/validate.dart';
import 'package:foody/widgets/app_bar.dart';
import 'package:foody/widgets/navigator_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final name = TextEditingController();
  final moblie = TextEditingController();
  final address = TextEditingController();

  final oldpassword = TextEditingController();
  final password = TextEditingController();
  final conform = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthService authService = AuthService();

  bool checkCurrentPassword = true;

  savePassword() async {
    checkCurrentPassword =
        await authService.checkCurrentPassword(oldpassword.text);

    setState(() {});
    if (_formKey.currentState!.validate() && checkCurrentPassword) {
      _formKey.currentState!.save();
      print('valid');
      try {
        var user = await FirebaseAuth.instance.currentUser!;
        await user.updatePassword(password.text);
        FirebaseDatabase.instance
            .ref('users')
            .child(user.uid)
            .update({'password': password.text});

        setState(() {
          oldpassword.clear();
          password.clear();
          conform.clear();
        });

        showSnackBar(context, Colors.green, "Change password is successful");
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, Colors.red, e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.info(
          context: context,
          voidCallback: () {
            savePassword();
          }),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                oldpasswordTextFormField(),
                SizedBox(
                  height: 30,
                ),
                passwordTextFormField(),
                SizedBox(
                  height: 30,
                ),
                conformTextFormField(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField oldpasswordTextFormField() {
    return TextFormField(
      controller: oldpassword,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your old password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline),
          errorText: checkCurrentPassword
              ? null
              : "Please check your current password"),
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
      validator: (text) {
        print('password is validating');
        return validatePassword(password.text);
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
      ),
      validator: (text) {
        print('conform is validating');
        var pass = _passKey.currentState!.value;
        return conformPassword(conform.text, pass);
      },
      onSaved: (value) {
        setState(() {
          print('conform is saved');
          conform.text = value!;
        });
      },
    );
  }
}
