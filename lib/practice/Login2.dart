import 'dart:ui';

import 'package:account_book2/mainpage.dart';
import 'package:account_book2/practice/animated_btn.dart';
import 'package:account_book2/practice/sign_in_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart' hide Image;

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 여러 요소 겹쳐서 배치
      body: Stack(
        children: [
          // Stack 내에서 특정 위치에 배치
          Positioned(
            // 화면 너비의 1.7배 크기로 배경 이미지 설정
            width: MediaQuery.of(context).size.width * 1.7,
            // 왼, 위, 아래 위치 설정
            left: 100,
            top: 40,
            bottom: 100,
            // 이미지 불러와 배경 설정
            child: Image.asset(
              "assets/Backgrounds/Spline.png",
            ),
          ),
          // 화면 전체에 배치
          Positioned.fill(
            // 배경을 필터링하는데 사용되는 위젯
            child: BackdropFilter(
              // 블러 효과 적용(x : 가로 / y : 세로)
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          // Rive 애니메이션 불러오기
          RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
          ),
          // 화면 전체에 배치
          Positioned.fill(
            // 배경을 필터링하는데 사용되는 위젯
            child: BackdropFilter(
              // 블러 효과 적용(x : 가로 / y : 세로)
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            "Learn design & code",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            if (!context.mounted) return;
                            showCustomDialog(
                              context,
                              onValue: (_) {},
                            );
                            // showCustomDialog(
                            //   context,
                            //   onValue: (_) {
                            //     setState(() {
                            //       isShowSignInDialog = false;
                            //     });
                            //   },
                            // );
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                          "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates."),
                    )
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
