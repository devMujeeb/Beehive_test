import 'package:beehive/auth_screens/create_account.dart';
import 'package:beehive/providers/auth_provider.dart';
import 'package:beehive/widgets/custom_button.dart';
import 'package:beehive/widgets/my_text_field.dart';
import 'package:beehive/widgets/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/colors.dart';

class LoginClass extends StatefulWidget {
  const LoginClass({Key? key}) : super(key: key);

  @override
  State<LoginClass> createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whtColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Login",
          style: TextStyle(
            fontFamily: "Cario",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: blkColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 4,
            ),
            Column(
              children: [
                const MyTextField(
                  headText: "Email",
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                passWordField(),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
            ),
            CustomButton(onPress: () {}, buttonName: "Login"),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    AppRoutes.push(context,const CreateAccountClass());
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontFamily: "Cario",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: themeColor,
                    ),
                  ),
                ),
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontFamily: "Cario",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: blkColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget passWordField() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password",
            style: TextStyle(
              fontFamily: "Cario",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<AuthProvider>(
            builder: (_, toggle, child) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                  fontFamily: "Cario",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: blkColor,
                ),
                obscureText: toggle.checkObscure,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: toggle.toggleObscure,
                    child: Icon(toggle.checkObscure == false
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  border: InputBorder.none,
                  hintText: "Enter",
                  hintStyle: const TextStyle(
                    fontFamily: "Cario",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 13, 15, 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
