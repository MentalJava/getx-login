import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  // late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get userProfile => auth.currentUser;
  var displayName = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(auth.currentUser);
  //   _user.bindStream(auth.userChanges());
  //   ever(_user, _moveToPage);
  // }

  // _moveToPage(User? user) {
  //   if (user == null) {
  //     Get.offAllNamed('/');
  //   } else {
  //     Get.offAllNamed('/home');
  //   }
  // }

  void signup(String name, email, password) async {
    isLoading.value = true;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = name;
        auth.currentUser?.updateDisplayName(name);
      });
      update();
      Get.offAllNamed('/');
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email';
      } else {
        message = e.message.toString();
      }
      Get.snackbar(
        title,
        message,
      );
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
