import 'package:account_book2/BottomPage/FirstPage.dart';
import 'package:account_book2/BottomPage/SecondPage.dart';
import 'package:account_book2/Widget/TotalMoney.dart';
import 'package:account_book2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Fourthtab extends StatelessWidget {
  const Fourthtab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TotalMoney(),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 30,
                      ),
                    ),
                    const Icon(Icons.add_card_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '예산',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.grey.shade200,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Row(
                        children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '예산설정',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 10,
                        height: 10,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 30,
                      ),
                    ),
                    const Icon(Icons.attach_money_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '자산',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${MainSelectDateTime.year.toString().substring(2)}.${MainSelectDateTime.month}.${FirstPageState.MainSelectFirstDay.day} ~ ${MainSelectDateTime.year.toString().substring(2)}.${MainSelectDateTime.month}.${FirstPageState.MainSelelctLastDay.day}',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 23),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '전월대비 지출 (당월/전월)',
                          ),
                          Spacer(),
                          Text(
                            '0%',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '지출 (현금,은행)',
                          ),
                          Spacer(),
                          Text(
                            '0원',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '지출 (카드)',
                          ),
                          Spacer(),
                          Text(
                            '0원',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '이체 (현금,은행->)',
                          ),
                          Spacer(),
                          Text(
                            '0원',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    // Padding 대신 SizedBox로 여백을 추가
                    const SizedBox(width: 22),
                    Expanded(
                      // 버튼이 Row의 여유 공간에 맞춰 크기를 자동으로 조정
                      child: SizedBox(
                        height: 40,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Colors.grey, // 버튼 테두리 색상
                                ),
                              ),
                            ),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white), // 배경색 설정
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                          ),
                          onPressed: () {
                            print('Click');
                          },
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // 텍스트와 아이콘 가운데 정렬
                            children: [
                              FaIcon(
                                FontAwesomeIcons.fileExcel,
                                color: Colors.lightGreen,
                              ),
                              SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
                              Text(
                                '메일로 엑셀파일 내보내기',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 22), // 오른쪽 여백
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
