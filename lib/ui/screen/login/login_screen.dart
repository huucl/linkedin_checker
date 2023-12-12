import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/ui/component/component_input.dart';
import 'package:flutter_chrome_app/ui/screen/login/login_controller.dart';
import 'package:flutter_chrome_app/utils/app_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: [
            SvgPicture.asset(AppSvg.heydevsLogo),
            const Text(
              ' HeyCRM duplicate checker',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login into your account',
                style: TextStyle(
                  color: Color(0xFF35353A),
                  fontSize: 32,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              ComponentInput(
                controller: controller.emailController,
                label: 'Your email',
                hintText: 'Insert your email',
              ),
              const SizedBox(height: 30),
              ComponentInput(
                controller: controller.passwordController,
                onFieldSubmitted: (_) {
                  controller.login();
                },
                label: 'Your password',
                hintText: 'Insert your password',
                isPasswordForm: true,
              ),
              const SizedBox(height: 30),
              const Text(
                'Forgot password?',
                style: TextStyle(
                  color: Color(0xFF1B64F5),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0.11,
                ),
              ),
              const SizedBox(height: 60),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: (){
                  controller.login();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF5D25FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF5F5F8),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
