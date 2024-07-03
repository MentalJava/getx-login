import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_login/src/controllers/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final authController = Get.put(AuthController());
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                'Reset\nPassword?',
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
                  Get.offAllNamed("/");
                },
                icon: const Icon(
                  Icons.arrow_back,
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
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Email',
                          style: GoogleFonts.gowunDodum(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffeb3349),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () {
                        if (authController.isLoading.value) {
                          return const CircularProgressIndicator();
                        } else {
                          return TextButton(
                            onPressed: () async {
                              String email = emailController.text.trim();
                              authController.sendPasswordResetEmail(email);
                            },
                            child: Container(
                              height: 55,
                              width: 400,
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
                                  'Reset Password',
                                  style: GoogleFonts.gowunDodum(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
