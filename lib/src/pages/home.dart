import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_login/src/controllers/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffeb3349), Color(0xfff45c43)],
                  stops: [0, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  left: 22,
                ),
                child: Text(
                  'Welcome!\n${authController.displayName.toString()}',
                  style: GoogleFonts.gowunDodum(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    authController.signOut();
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 230,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/user.jpg',
                      ),
                      height: 200,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Really delete it?',
                          content: Obx(
                            () => TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      authController.obscurePassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      authController.obscurePassword.value =
                                          !authController.obscurePassword.value;
                                    },
                                  ),
                                  hintText: "password"),
                              obscureText: authController.obscurePassword.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          confirm: Obx(
                            () {
                              if (authController.isLoading.value) {
                                return const CircularProgressIndicator();
                              } else {
                                return TextButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      String password = passwordController.text;
                                      authController.deleteAccount(password);
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xffeb3349),
                                          Color(0xfff45c43)
                                        ],
                                        stops: [0, 1],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Delete Account',
                                        style: GoogleFonts.gowunDodum(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 400,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xffeb3349), Color(0xfff45c43)],
                            stops: [0, 1],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Delete Account",
                            style: GoogleFonts.gowunDodum(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
