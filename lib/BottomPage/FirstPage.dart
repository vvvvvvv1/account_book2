import 'package:account_book2/Api/api_service.dart';
import 'package:account_book2/Login.dart';
import 'package:account_book2/Model/api_model.dart';
import 'package:account_book2/TabBar/FifthTab.dart';
import 'package:account_book2/TabBar/FirstTab.dart';
import 'package:account_book2/TabBar/FourthTab.dart';
import 'package:account_book2/TabBar/SecondTab.dart';
import 'package:account_book2/TabBar/ThirdTab.dart';
import 'package:account_book2/accountbook_add.dart';
import 'package:account_book2/main.dart';
import 'package:account_book2/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => FirstPageState();
}

// _FirstPageState면 private
// _ 빼면 public
class FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  DateTime MainSelectDateTime = DateTime.now();

  /// 해당 년월 첫날 표출
  static DateTime MainSelectFirstDay =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  /// 해당 년월 마지막날 표출
  static DateTime MainSelelctLastDay =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  /// 해당년도 표출
  DateTime MainSelectYear = DateTime.now();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    /// 특정 Tab 클릭 시 다른 AppBar 표출
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  /// 연도와 월 업데이트 (화살표 아이콘 클릭)
  void _updateYearMonth(int monthChange) {
    setState(() {
      MainSelectDateTime = DateTime(
          MainSelectDateTime.year, MainSelectDateTime.month + monthChange);

      // 해당 달의 1일 표출
      MainSelectFirstDay = DateTime(
          MainSelectFirstDay.year, MainSelectFirstDay.month + monthChange, 1);

      // 해당 달의 마지막일 표출
      MainSelelctLastDay = DateTime(MainSelelctLastDay.year,
          MainSelelctLastDay.month + monthChange + 1, 0);
    });
  }

  /// 연도 업데이트 (화살표 아이콘 클릭)
  void _updateYear(int yearChange) {
    setState(() {
      MainSelectYear = DateTime(MainSelectYear.year + yearChange);
    });
  }

  /// showDatePicker를 사용하여 년월 선택 및 선택 날짜 변수에 저장 (년월 선택)
  Future<void> _selectYearMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: MainSelectDateTime, // 다이얼로그 열릴 때 기본 선택된 날짜
      firstDate: DateTime(2000), // 사용자가 선택할 수 있는 가장 이른 날짜
      lastDate: DateTime(2100), // 사용자가 선택할 수 있는 가장 마지막 날짜
      initialDatePickerMode: DatePickerMode.year, // 다이얼로그가 열릴 때 연도 선택 모드로 시작
      helpText: "년월 선택", // 다이얼로그 상단에 표시되는 텍스트
    );
    if (picked != null) {
      setState(() {
        MainSelectDateTime = DateTime(picked.year, picked.month); // 선택한 년, 월 저장
      });
    }
  }

  /// showDatePicker를 사용하여 년월 선택 및 선택 날짜 변수에 저장 (년도 선택)
  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: MainSelectYear, // 다이얼로그 열릴 때 기본 선택된 날짜
      firstDate: DateTime(2000), // 사용자가 선택할 수 있는 가장 이른 날짜
      lastDate: DateTime(2100), // 사용자가 선택할 수 있는 가장 마지막 날짜
      initialDatePickerMode: DatePickerMode.year, // 다이얼로그가 열릴 때 연도 선택 모드로 시작
      helpText: "년도 선택", // 다이얼로그 상단에 표시되는 텍스트
    );
    if (picked != null) {
      // 특정 오브젝트의 상태(값)를 변경하기 위해 사용
      setState(() {
        MainSelectYear = DateTime(picked.year); // 선택한 년, 월 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<ApiModel>> apimodel = ApiService.getApiData();

    final storage = FlutterSecureStorage();
    return MaterialApp(
      // 디버그 배너 없애기
      debugShowCheckedModeBanner: false,
      // TabBar 및 TabBarView 위젯을 구현할 수 있게 해주는 위젯
      home: DefaultTabController(
        // 탭의 수 정의
        length: 5,
        child: Scaffold(
          /// AppBar
          appBar: AppBar(
            // 왼쪽 버튼 없앨 때 사용 (<-, 햄버거 버튼)
            automaticallyImplyLeading: true,
            // AppBar 배경색
            backgroundColor: Colors.white,
            // AppBar leading 위젯 너비 설정
            leadingWidth: 185,

            /// tab index가 2이면 년도만 표출 / 아니면 년월 표출
            leading: _tabController.index == 2
                ? Row(
                    children: [
                      /// <-
                      IconButton(
                        // 년도 값 (-)
                        onPressed: () => _updateYear(-1),
                        icon: const Icon(Icons.arrow_back),
                      ),

                      /// ex) 2025년
                      /// 사용자 동작 감지 위젯
                      GestureDetector(
                        onTap: () =>
                            _selectYear(context), // 텍스트 클릭 시 DatePicker 열기
                        child: Text(
                          "${MainSelectYear.year}년",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),

                      /// ->
                      IconButton(
                        // 년도 값 (+)
                        onPressed: () => _updateYear(1),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      /// <-
                      IconButton(
                        iconSize: 18,
                        // 년월 값 (-)
                        onPressed: () => _updateYearMonth(-1),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        /// ex) 2025년
                        /// 사용자 동작 감지 위젯
                        child: GestureDetector(
                          onTap: () => _selectYearMonth(
                              context), // 텍스트 클릭 시 DatePicker 열기
                          child: Text(
                            "${MainSelectDateTime.year}년 ${MainSelectDateTime.month}월",
                            style: const TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      /// ->
                      IconButton(
                        iconSize: 18,
                        // 년월 값 (+)
                        onPressed: () => _updateYearMonth(1),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.star_border),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.list),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () async {
                  // 저장된 사용자 이름 불러오기
                  String? username = await storage.read(key: "username");

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('로그아웃'),
                        content: Text('${username}님 로그아웃 하시겠습니까?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              // 저장된 로그인 정보 삭제
                              await storage.delete(key: "username");

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(),
                                ),
                              );
                            },
                            child: Text('확인'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('취소'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],

            /// TabBar
            bottom: TabBar(
                // 컨트롤러 설정
                controller: _tabController,
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
                // 탭 바에 표시될 탭 콘텐츠 정의
                tabs: const [
                  Tab(
                    text: "일일",
                  ),
                  Tab(
                    text: "달력",
                  ),
                  Tab(
                    text: "월별",
                  ),
                  Tab(
                    text: "결산",
                  ),
                  Tab(
                    text: "메모",
                  ),
                ]),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              /// 첫번째 탭
              Firsttab(),

              /// 두번째 탭
              Secondtab(),

              /// 세번째 탭
              Thirdtab(),

              /// 네번째 탭
              Fourthtab(),

              /// 다섯번째 탭
              Fifthtab(),
            ],
          ),
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.red.shade400,
                  ),
                ),
                child: Icon(
                  Icons.assignment_add,
                  color: Colors.red.shade400,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: 'chat',
                backgroundColor: Colors.red.shade400,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountbookAdd(),
                    ),
                  );
                },
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
