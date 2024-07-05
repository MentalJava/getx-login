import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_login/src/controllers/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  SignUp({
    super.key,
  });

  final authController = Get.put(AuthController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
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
                    'Create Your\nAccount!',
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
                      Get.offAllNamed('/');
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Name',
                              style: GoogleFonts.gowunDodum(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffeb3349),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "please enter a vaild email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: _passwordController,
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
                              label: Text(
                                'Password',
                                style: GoogleFonts.gowunDodum(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffeb3349),
                                ),
                              ),
                            ),
                            obscureText: authController.obscurePassword.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: _confirmpassController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  authController.obscureConfirmPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  authController.obscureConfirmPassword.value =
                                      !authController
                                          .obscureConfirmPassword.value;
                                },
                              ),
                              label: Text(
                                'Confirm Password',
                                style: GoogleFonts.gowunDodum(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffeb3349),
                                ),
                              ),
                            ),
                            obscureText:
                                authController.obscureConfirmPassword.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(
                          () {
                            if (authController.isLoading.value) {
                              return const CircularProgressIndicator();
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    String name = _nameController.text.trim();
                                    String email = _emailController.text.trim();
                                    String password = _passwordController.text;
                                    authController.signup(
                                        name, email, password);
                                  }
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
                                      'SIGN UP',
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
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Do you have an account?",
                                style: GoogleFonts.gowunDodum(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/login');
                                },
                                child: Text(
                                  "Sign in",
                                  style: GoogleFonts.gowunDodum(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff281537),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
