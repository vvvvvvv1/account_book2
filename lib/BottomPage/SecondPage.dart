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

// 현재 날짜
DateTime MainSelectDateTime = DateTime.now();

// 드롭다운 메뉴 리스트
List<String> DropDownList = ['주간', '월간', '연간', '기간'];

// 기본 선택값
String dropDownValue = "주간";

// 차트에서 터치된 섹션 인덱스
int touchedIndex = 1;

// API에서 가져온 데이터 저장
final Future<List<ApiModel>> apimodel = ApiService.getApiData();

class _SecondPageState extends State<SecondPage> {
  /// 연도와 월 업데이트 (화살표 아이콘 클릭)
  void _updateYearMonth(int MonthValue) {
    setState(() {
      MainSelectDateTime = DateTime(
          MainSelectDateTime.year, MainSelectDateTime.month + MonthValue);
    });
  }

  // showDatePicker를 사용하여 년 선택 및 선택 날짜 변수에 저장 (년도 선택)
  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: MainSelectDateTime, // 다이얼로그 열릴 때 기본 선택된 날짜
      firstDate: DateTime(2000), // 사용자가 선택할 수 있는 가장 이른 날짜
      lastDate: DateTime(2100), // 사용자가 선택할 수 있는 가장 마지막 날짜
      initialDatePickerMode: DatePickerMode.year, // 다이얼로그가 열릴 때 연도 선택 모드로 시작
      helpText: "년도 선택", // 다이얼로그 상단에 표시되는 텍스트
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 배너 없애기
      debugShowCheckedModeBanner: false,
      // TabBar 및 TabBarView 위젯을 구현할 수 있게 해주는 위젯
      home: DefaultTabController(
        // 탭의 수 정의
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // AppBar 배경색
            backgroundColor: Colors.white,
            // AppBar leading 위젯 너비 설정
            leadingWidth: 185,
            leading: Row(
              children: [
                // <
                IconButton(
                  // 년월 값 (-)
                  onPressed: () => _updateYearMonth(-1),
                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                ),

                /// ex) 2025년 1월
                /// 사용자 동작 감지 위젯
                GestureDetector(
                  onTap: () => _selectYear(context), // 텍스트 클릭 시 DatePicker 열기
                  child: Text(
                    '${MainSelectDateTime.year}년 ${MainSelectDateTime.month}월',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // >
                IconButton(
                  // 년월 값 (+)
                  onPressed: () => _updateYearMonth(1),
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
            actions: [
              Column(children: [
                // 여백 추가
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
                  // 드롭다운 버튼
                  child: DropdownButton(
                    // 초기값 설정 (주간)
                    value: dropDownValue,
                    // .map<T>(callback) : 리스트의 모든 요소를 새로운 형태로 변환하는 함수
                    // DropDownList의 각 item을 DropdownMenuItem<String> 객체로 변환.
                    items: DropDownList.map<DropdownMenuItem<String>>(
                        (String item) {
                      return DropdownMenuItem<String>(
                        // 항목 실제 값 설정
                        value: item,
                        // 화면에 표시되는 텍스트 설정
                        child: Text('$item'),
                      );
                    }).toList(),
                    // 새로운 값을 선택했을 때 실행되는 함수
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
              // 너비와 높이 비율 조정
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
                        // 차트의 가로 세로 비율 1:1 정사각형으로 맞춤
                        aspectRatio: 1,
                        child: PieChart(
                          // 파이 차트의 설정 및 데이터
                          PieChartData(
                            // 터치 이벤트 처리
                            pieTouchData: PieTouchData(
                              // 파이 차트 터치 시 실행
                              touchCallback:
                                  // 터치 이벤트 정보, 파이 차트의 터치 관련 데이터
                                  (FlTouchEvent event, PieTouchResponse) {
                                setState(() {
                                  // 차트와 관련없는 터치일때
                                  if (!event.isInterestedForInteractions ||
                                      // 터치 이벤트가 발생하지 않았을때
                                      PieTouchResponse == null ||
                                      // 터치된 조각이 없을 때
                                      PieTouchResponse.touchedSection == null) {
                                    // 아무 조각도 선택되지 않은 상태
                                    touchedIndex = -1;
                                    return;
                                  }
                                  // 터치된 파이 차트의 조각을 변수에 저장
                                  // touchedSection! : null 아님을 보장
                                  // touchedSectionIndex : 터치된 조각의 인덱스 값
                                  touchedIndex = PieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            // 차트 테두리 설정
                            borderData: FlBorderData(
                              // 테두리 숨김
                              show: false,
                            ),
                            // 파이 조각 간격을 없앰
                            sectionsSpace: 0,
                            // 가운데 원형 공간 추가(도넛 모양 효과)
                            centerSpaceRadius: 30,
                            // 차트 데이터 설정
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
  // 길이가 4인 리스트 생성 (i는 0부터 3까지 증가)
  return List.generate(4, (i) {
    // 현재 인덱스가 touchedIndex와 같은지 확인
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          // 색상
          color: AppColors.contentColorBlue,
          // 비율
          value: 40,
          // 제목
          title: '40%',
          // 반지름
          radius: radius,
          // 타이틀 텍스트 스타일
          titleStyle: TextStyle(
            // 글자 크기
            fontSize: fontSize,
            // 글자 굵기
            fontWeight: FontWeight.bold,
            // 글자 색상
            color: AppColors.mainTextColor1,
            // 그림자
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
