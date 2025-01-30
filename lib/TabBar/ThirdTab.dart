import 'package:account_book2/Widget/TotalMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 세번째 탭
class Thirdtab extends StatelessWidget {
  const Thirdtab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TotalMoney(),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                ExpansionTile(
                  showTrailingIcon: false,
                  title: Column(
                    children: [
                      Row(
                        children: [
                          const Text('12월'),
                          SizedBox(
                            width: 180,
                          ),
                          Text(
                            '0원',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '0원',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '12.1 ~ 12.31',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '0원',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  children: [
                    Container(
                      color: Colors.grey,
                      child: const ListTile(
                        title: Text('12 ~ 12'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
