import 'package:flutter/material.dart';
import 'package:foody/data/handle/auth_service.dart';
import 'package:foody/data/validate.dart';
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

  AuthService authService = AuthService();

  register() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print('valid');
      await authService.register(email.text, password.text).then((value) async {
        if(value==true){
          showSnackBar(context, Colors.green, "Register successfully");
          Navigator.pop(context);
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
                label: 'Sign Up',
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
      ),

      validator: (text){
        print('email is validating');
        return validateEmail(email.text);
      },
      onSaved: (value){
        setState(() {
          print('email is saved');
          email.text = value!;
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
      validator: (text){
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
      validator: (text){
        print('conform is validating');
        var pass = _passKey.currentState!.value;
        return conformPassword(conform.text, pass);
      },
      onSaved: (value){
        setState(() {
          print('conform is saved');
          conform.text = value!;
        });
      },
    );
  }
}