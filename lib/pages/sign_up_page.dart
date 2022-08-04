import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/pages/sign_in_page.dart';
import 'package:firebase_note/services/auth_service.dart';
import 'package:firebase_note/services/db_service.dart';
import 'package:firebase_note/services/util_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const id = 'sign_up_page';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  bool isLoading = false;


  void _signUp(){
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = "$firstName $lastName";

    if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty){
      Utils.fireSnackBar("Fill all gaps first", context);
      return;
    }

    isLoading = true;
    setState(() {});

    AuthService.signUpUser(context, name, email, password).then((user) => _checkNewUser(user)).catchError(_catchError);


  }

  void _checkNewUser(User? user)async{
    if(user != null){
      await DBService.saveUserId(user.uid);
      if(mounted)Navigator.pushReplacementNamed(context, SignInPage.id);
    }else{
      Utils.fireSnackBar("Check your data and try again", context);
    }
    isLoading = false;
    setState(() {});
  }

  void _catchError(){
    Utils.fireSnackBar("Smth went wrong", context);
    isLoading = false;
    setState(() {});
  }

  void _goSignIn(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          primary: true,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //email
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText: "Firstname",
                  ),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),

                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText: "Lastname",
                  ),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),

                //password
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                ),

                const SizedBox(
                  height: 20,
                ),

                //sign_in
                ElevatedButton(
                  onPressed: _signUp,
                  style: ButtonStyle(
                      minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50))),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      children:[
                        const TextSpan(
                            text: "Already have an account?  "
                        ),
                        TextSpan(
                          style: const TextStyle(
                              color: Colors.blue
                          ),
                          text: "Sign In",
                          recognizer: TapGestureRecognizer()..onTap = _goSignIn,
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
