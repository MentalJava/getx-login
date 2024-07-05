import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get userProfile => auth.currentUser;
  var displayName = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  Future<void> signup(String name, email, password) async {
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

  Future<void> signIn(String email, password) async {
    isLoading.value = true;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => displayName = userProfile!.displayName!);
      update();
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid password. please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            'The account does not exists for $email. Create your account by signing up.';
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

  Future<void> signOut() async {
    try {
      await auth.signOut();
      displayName = '';
      update();
      Get.offAllNamed('/');
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      auth.sendPasswordResetEmail(email: email).then((valeu) {
        Get.offAllNamed('/');
        Get.snackbar('이메일 전송 완료', '성공!');
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteAccount(String password) async {
    User? user = auth.currentUser;
    if (user != null && password.isNotEmpty) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await user.delete();
        update();
        Get.offAllNamed('/');
        Get.snackbar('Success', 'Your account has been successfully deleted');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', 'Failed to delete account ${e.message}');
      }
    } else {
      Get.snackbar('Error', 'Please enter your password');
    }
  }
}
