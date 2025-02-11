import 'package:account_book2/Api/api_service.dart';
import 'package:account_book2/Model/api_model.dart';
import 'package:account_book2/resources/app_colors.dart';
import 'package:account_book2/resources/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
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

int touchedIndex = 1;

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
          body: Column(
            children: [
              AspectRatio(
                // 가로가 세로보다 1.3배 김
                aspectRatio: 1.3,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, PieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      PieTouchResponse == null ||
                                      PieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = PieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Indicator(
                          color: AppColors.contentColorBlue,
                          text: 'First',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: AppColors.contentColorYellow,
                          text: 'Second',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: AppColors.contentColorPurple,
                          text: 'Third',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: AppColors.contentColorGreen,
                          text: 'Fourth',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 28,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: AppColors.contentColorBlue,
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: AppColors.contentColorYellow,
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: AppColors.contentColorPurple,
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: AppColors.contentColorGreen,
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
