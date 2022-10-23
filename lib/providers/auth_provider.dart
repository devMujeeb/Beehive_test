import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beehive/widgets/colors.dart';
import 'package:beehive/widgets/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/const_function.dart';

class AuthProvider with ChangeNotifier {
  bool checkObscure = true;
  void toggleObscure() {
    checkObscure = !checkObscure;
    notifyListeners();
  }

  final picker = ImagePicker();
  File? getImage;

  imgFromCamera() async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getImage = File(pickedFile!.path);
    notifyListeners();
  }

  imgFromGallery() async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getImage = File(pickedFile!.path);
    notifyListeners();
  }

  void showPicker(
    context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Preferred Option",
                  style: TextStyle(
                    color: blkColor,
                    fontFamily: "Cario",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    imgFromCamera();
                    AppRoutes.pop(context);
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Open Camera",
                        style: TextStyle(
                          color: blkColor,
                          fontFamily: "Cario",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    imgFromGallery();
                    AppRoutes.pop(context);
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.file_copy,
                        color: Colors.black,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Select From Gallery",
                        style: TextStyle(
                          color: blkColor,
                          fontFamily: "Cario",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  bool loading = false;
  void loginValidation(
      TextEditingController email, TextEditingController password, context) {
    if (email.text.isNotEmpty && isEmail(email.text)) {
      if (password.text.length > 5) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then((v) {
          String user = v.user!.uid;
          if (user.isNotEmpty) {
            // userUploadToDB(context);
          } else {
            showToast("Something Wrong", context);
          }
        }).onError((error, stackTrace) {
          print(error);
          if (error.toString().contains("password is invalid")) {
            showToast("Email or Password is incorrect", context);
          } else {
            showToast("Something wrong please try again later", context);
          }
        });
      } else {
        showToast("Please enter valid password", context);
      }
    } else {
      showToast("Please enter valid email", context);
    }
    notifyListeners();
  }

  String uid = "";

  String categoryDropDownValue = "";

  categoryDropDownFunction(value) {
    categoryDropDownValue = value!;
    notifyListeners();
  }

  void createUserValidation(
    TextEditingController storeName,
    TextEditingController email,
    TextEditingController number,
    TextEditingController password,
    TextEditingController storeLocation,
    TextEditingController maroofCode,
      context,
  ) {
    if (getImage != null) {
      if (storeName.text.isNotEmpty) {
        if (categoryDropDownValue != "") {
          if (email.text.isNotEmpty && isEmail(email.text)) {
              if (number.text.isNotEmpty) {
                if (password.text.isNotEmpty) {
                  if (storeLocation.text.isNotEmpty) {
                    if (maroofCode.text.isNotEmpty) {
                        createUser(storeName,email,number,password,storeLocation,maroofCode,context);
                      } else {
                        showToast("please enter your maroof code", context);
                      }
                  } else {
                    showToast("Please enter your store location", context);
                  }
                } else {
                  showToast("Please enter your password", context);
                }
              } else {
                showToast("Please enter your mobile number", context);
              }
          } else {
            showToast("Please enter correct email", context);
          }
        } else {
          showToast("Please select category value", context);
        }
      } else {
        showToast("Please enter Store Name", context);
      }
    } else {
      showToast("Please add profile image", context);
    }
    notifyListeners();
  }

  void createUser(
      TextEditingController storeName,
      TextEditingController email,
      TextEditingController number,
      TextEditingController password,
      TextEditingController storeLocation,
      TextEditingController maroofCode,
      context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text.toString().trim(),
            password: password.text.toString())
        .then((v) {
      uid = v.user!.uid;
      uploadPic(getImage!, context,storeName,email,number,password,storeLocation,maroofCode);
    }).onError((error, stackTrace) {
      loading = false;
      if (error.toString().contains("email-already-in-use")) {
        showToast(
            "The email address is already in use by another account.", context);
      } else {
        showToast("Something wrong\n Please try again later", context);
      }
      print(error);
    });
    notifyListeners();
  }

  String imgUrl = "";
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void uploadPic(File imageFile, context,
  TextEditingController storeName,
      TextEditingController email,
  TextEditingController number,
      TextEditingController password,
  TextEditingController storeLocation,
      TextEditingController maroofCode,
      ) async {
    String imgPath = imageFile.path.split("/").last;
    Reference reference = _storage.ref().child("images/$uid/$imgPath");
    Task upload = reference.putFile(imageFile);
    upload.then((v) async {
      String url = await v.ref.getDownloadURL();
      print("URL is $url");
      imgUrl = url;
      userUploadToDB(storeName,email,number,storeLocation,maroofCode,context);
    });
    notifyListeners();
  }

  void userUploadToDB(
      TextEditingController storeName,
      TextEditingController email,
      TextEditingController number,
      TextEditingController storeLocation,
      TextEditingController maroofCode,
      context,
      ) {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> data = {
      "userCreateTime":timestamp,
      "uid": uid,
      "img_url": imgUrl,
      "storeName": storeName.text,
      "category": categoryDropDownValue,
      "email": email.text,
      "mobileNumber": number.text,
      "storeLocation": storeLocation.text,
      "maroofCode": maroofCode.text,
    };
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .set(
          data,
        )
        .then((va) async {
          // AppRoutes.makeFirst(context, HomePage());
      showToast("Thanks for Sign Up", context);
    });
    notifyListeners();
  }
}
