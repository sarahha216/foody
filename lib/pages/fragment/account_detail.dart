import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/auth_service.dart';
import 'package:foody/pages/change_password.dart';
import 'package:foody/pages/sign_in_page.dart';
import 'package:foody/widgets/avatar_widget.dart';
import 'package:foody/widgets/list_title_widget.dart';
import 'package:foody/widgets/navigator_widget.dart';

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

  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthService authService = AuthService();

  Future signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text("Account"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: databaseReference.child(uid).onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data!.snapshot;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                child: Column(
                  children: [
                    AvatarWidget.base(
                        size: 80.0,
                        isBorder: true,
                        name: "${user.child("name").value}"),
                    SizedBox(
                      height: 12.0,
                    ),
                    ListTitleWidget.base(
                        content: "Change password",
                        prefixIcon: Icons.key,
                        iconColor: Colors.black87,
                        onTap: () {
                          nextScreen(context, ChangePassword());
                        }),
                    ListTitleWidget.base(
                        content: "Log out",
                        prefixIcon: Icons.lock,
                        iconColor: Colors.red,
                        contentStyle:
                            const TextStyle(fontSize: 18.0, color: Colors.red),
                        onTap: () {
                          signOut();
                          nextScreenRemove(context, SignInPage());
                        })
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(""),
              );
            }
          },
        ),
      ),
    );
  }
}
