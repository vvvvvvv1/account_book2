import 'package:account_book2/BottomPage/SecondPage.dart';
import 'package:account_book2/Widget/TotalMoney.dart';
import 'package:account_book2/accountbook_DetailPage.dart';
import 'package:account_book2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 첫번째 탭
class Firsttab extends StatelessWidget {
  const Firsttab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 수입, 지출, 합계
        const TotalMoney(),
        Expanded(
            // List에 데이터 없으면 데이터 없음 텍스트 표출 / 있으면 데이터 표출
            child: FutureBuilder(
          future: apimodel,
          builder: (context, snapshot) {
            // 데이터 로딩중
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('데이터 없음'));
            } else {
              final apimodel = snapshot.data!;
              return ListView.builder(
                // 보여주려는 데이터 개수
                itemCount: apimodel.length,
                // itemCount 만큼 반복되며 화면에 보여주려는 위젯
                // index가 0부터 transactions.length - 1까지 증가하며 전달됩니다.
                itemBuilder: (context, index) {
                  // transactions index에 해당하는 data 꺼내기
                  final trans = apimodel[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              trans.date,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                trans.dayOfWeek,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${MainSelectDateTime.year}. ${MainSelectDateTime.month}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 150,
                            ),
                            Text(
                              '${trans.income}원',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${trans.expense}원',
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  id: trans.id,
                                  date: trans.date,
                                  dayOfWeek: trans.dayOfWeek,
                                  category: trans.category,
                                  description: trans.description,
                                  time: trans.time,
                                  bank: trans.bank,
                                  income: trans.income,
                                  expense: trans.expense,
                                  fulldate: trans.fulldate,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.car,
                                ),
                                Text(
                                  trans.category,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${trans.description}\n',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${trans.time}  ${trans.bank}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //const Spacer(),
                                Text(
                                  '${trans.income}원',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        )),
      ],
    );
  }
}
