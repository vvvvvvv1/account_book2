import 'package:account_book2/Api/api_service.dart';
import 'package:account_book2/Model/api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

DateTime MainSelectDateTime = DateTime.now();

List<String> DropDownList = ['주간', '월간', '연간', '기간'];

String dropDownValue = "주간";

final Future<List<ApiModel>> apimodel = ApiService.getApiData();

class _SecondPageState extends State<SecondPage> {
  void _updateYearMonth(int MonthValue) {
    setState(() {
      MainSelectDateTime = DateTime(
          MainSelectDateTime.year, MainSelectDateTime.month + MonthValue);
    });
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: MainSelectDateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
      helpText: "년도 선택",
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 185,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () => _updateYearMonth(-1),
                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                ),
                GestureDetector(
                  onTap: () => _selectYear(context),
                  child: Text(
                    '${MainSelectDateTime.year}년 ${MainSelectDateTime.month}월',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _updateYearMonth(1),
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
            actions: [
              Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey, width: 2), // 테두리 색상과 두께 설정
                    borderRadius: BorderRadius.circular(8), // 테두리 둥글게 설정
                  ),
                  child: DropdownButton(
                    value: dropDownValue,
                    items: DropDownList.map<DropdownMenuItem<String>>(
                        (String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text('$item'),
                      );
                    }).toList(),
                    onChanged: (String? Value) {
                      setState(() {
                        dropDownValue = Value!;
                        print(dropDownValue);
                      });
                    },
                  ),
                )
              ])
            ],
            bottom: TabBar(
                // 스크롤 가능 여부
                isScrollable: false,
                // 탭 아래 표시되는 선 색상 설정
                indicatorColor: Colors.red,
                // 탭 아래 표시되는 선 두께 설정
                indicatorWeight: 4,
                // 탭 텍스트 색상
                labelColor: Colors.black,
                // 탭 아래 표시되는 선 크기 설정
                indicatorSize: TabBarIndicatorSize.tab,
                // 선택된 탭 스타일
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // 선택되지 않은 탭 스타일
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                tabs: [
                  Tab(text: '수입'),
                  Tab(text: '지출'),
                ]),
          ),
          body: FutureBuilder(
            future: apimodel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TabBarView(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var a = snapshot.data![index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: Text(a.category),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 20,
                                  ),
                              itemCount: snapshot.data!.length),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        // 드래그 되는 text 위젯
                        SelectableText.rich(TextSpan(
                          children: [
                            TextSpan(text: '테스트'),
                          ],
                        )),
                      ],
                    ),
                  ],
                );
              } else
                return Center(
                  child: Text('err: ${snapshot.error}'),
                );
            },
          ),
        ),
      ),
    );
  }
}
