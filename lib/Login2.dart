import 'dart:ui';

import 'package:account_book2/mainpage.dart';
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
  // 버튼 안보이게 초기 설정
  bool isvisble = false;

  @override
  void initState() {
    fadeButton();
    super.initState();
  }

  void fadeButton() {
    // 0.5초 뒤에 버튼 보임
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isvisble = true;
      });
    });
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
            duration: Duration(
              milliseconds: 240,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            'Learn design & code',
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.',
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    AnimatedOpacity(
                      // 변수 값에 따라 투명도 지정
                      opacity: isvisble ? 1.0 : 0.0,
                      // 지속시간 1초
                      duration: Duration(seconds: 1),
                      child: SizedBox(
                        width: 230,
                        height: 50,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white),
                            side: WidgetStateProperty.all(
                              BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Future.delayed(Duration(milliseconds: 800), () {
                              showGeneralDialog(
                                barrierDismissible: true,
                                barrierLabel: "Sign In",
                                context: context,
                                transitionDuration: Duration(milliseconds: 400),
                                transitionBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  Tween<Offset> tween;
                                  tween = Tween(
                                      begin: Offset(0, -1), end: Offset.zero);
                                  return SlideTransition(
                                    position: tween.animate(
                                      CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.elasticOut),
                                    ),
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Center(
                                  child: Container(
                                    height: 600,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 35,
                                      vertical: 50,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 30,
                                      horizontal: 24,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Sign in',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontFamily: "Poppins"),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.',
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Form(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Email',
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: SvgPicture.asset(
                                                              "assets/icons/email.svg"),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'password',
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      obscureText: true,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: SvgPicture.asset(
                                                              "assets/icons/password.svg"),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xFFF77D8E),
                                                        minimumSize: Size(
                                                            double.infinity,
                                                            56),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    25),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    25),
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        CupertinoIcons
                                                            .arrow_right,
                                                      ),
                                                      label: Text(
                                                        'Sign In',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: -48,
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.close),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_right_alt,
                              ),
                              Text(
                                'start',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.',
                    ),
                    SizedBox(
                      height: 30,
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
