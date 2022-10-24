import 'package:beehive/auth_screens/login.dart';
import 'package:beehive/providers/auth_provider.dart';
import 'package:beehive/widgets/colors.dart';
import 'package:beehive/widgets/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/my_text_field.dart';

class CreateAccountClass extends StatefulWidget {
  const CreateAccountClass({Key? key}) : super(key: key);

  @override
  State<CreateAccountClass> createState() => _CreateAccountClassState();
}

class _CreateAccountClassState extends State<CreateAccountClass> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController storeLocationController = TextEditingController();
  final TextEditingController maroofCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whtColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AppRoutes.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: blkColor,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Create Account",
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
              height: MediaQuery.of(context).size.width / 25,
            ),
            Consumer<AuthProvider>(
              builder: (index, imageFileData, child) => SizedBox(
                child: Stack(
                  children: [
                    imageFileData.getImage != null
                        ? Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                imageFileData.getImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: whtColor,
                              size: 30,
                            ),
                          ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          imageFileData.showPicker(
                            context,
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: themeColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            MyTextField(
              headText: "Store Name",
              controller: storeNameController,
              inputType: TextInputType.name,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            categoryDropDown(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            MyTextField(
              controller: emailController,
              headText: "Email",
              inputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            MyTextField(
              headText: "Mobile Number",
              controller: mobileNumberController,
              inputType: TextInputType.number,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            passWordField(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            locationField(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            MyTextField(
              headText: "Maroof Code",
              controller: maroofCodeController,
              inputType: TextInputType.number,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            Consumer<AuthProvider>(
              builder: (_, createAcc, child) => CustomButton(
                  onPress: () {
                    createAcc.createUserValidation(
                      storeNameController,
                      emailController,
                      mobileNumberController,
                      passwordController,
                      storeLocationController,
                      maroofCodeController,
                      context,
                    );
                  },
                  buttonName: "Create account"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    AppRoutes.pop(context);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Cario",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: themeColor,
                    ),
                  ),
                ),
                Text(
                  "Have an account?",
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

  Widget categoryDropDown() {
    return Consumer<AuthProvider>(
      builder: (_, categoryData, child) => Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Category",
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
            Container(
              height: 55,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: "Select Category",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  isCollapsed: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                isExpanded: true,
                iconSize: 30.0,
                items: ["a", "b", "c", "d", "e"].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(
                        val,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  categoryData.categoryDropDownFunction(val);
                  // print("drop down value ${dropDownData.countryDropDownValue}");
                },
              ),
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
                controller: passwordController,
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

  Widget locationField() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Store Location",
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
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xffFEF7F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Chosse from map",
                      style: TextStyle(
                        fontFamily: "Cario",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: themeColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: storeLocationController,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(
                      fontFamily: "Cario",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: blkColor,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter",
                      hintStyle: TextStyle(
                        fontFamily: "Cario",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 13, 15, 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
Route loginRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginClass(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}