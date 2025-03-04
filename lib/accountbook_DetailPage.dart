import 'package:account_book2/Api/api_service.dart';
import 'package:account_book2/Expense_add.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final String date;
  final String dayOfWeek;
  final String category;
  final String description;
  final String time;
  final String bank;
  final int income;
  final int expense;
  final String fulldate;

  const DetailPage({
    super.key,
    required this.id,
    required this.date,
    required this.dayOfWeek,
    required this.category,
    required this.description,
    required this.time,
    required this.bank,
    required this.income,
    required this.expense,
    required this.fulldate,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // 날짜 입력 칸
  TextEditingController _dateTimeController = TextEditingController();
  // 금액 입력 칸
  TextEditingController amountController = TextEditingController();
  // 분류 입력 칸
  TextEditingController classController = TextEditingController();
  // 자산 입력 칸
  TextEditingController assetController = TextEditingController();
  // 내용 입력 칸
  TextEditingController detailController = TextEditingController();
  // 메모 입력 칸
  TextEditingController memoController = TextEditingController();

  DateTime selectDateTime = DateTime.now(); // 사용자가 선택한 날짜와 시간을 저장d

  final List<bool> _isSelected = [false, false, false];

  String title = "";
  String title1 = "";
  String title2 = "";

  int selectedIndex = 0;
  int id = 0;

  // 왼쪽 카테고리 목록
  final List<String> categories = [
    "식비",
    "교통/차량",
    "문화생활",
    "마트/편의점",
    "패션/미용",
    "생활용품"
  ];

  // 오른쪽 세부 메뉴
  final Map<String, List<String>> details = {
    "식비": ["식료품", "간식", "외식", "음료"],
    "교통/차량": ["대중교통", "택시", "주유", "차량 정비"],
    "문화생활": ["영화", "공연", "전시회", "여행"],
    "마트/편의점": ["마트", "편의점"],
    "패션/미용": ["의류", "화장품", "미용"],
    "생활용품": ["가구", "주방용품", "청소용품"]
  };

  // 선택 버튼 찾기
  void _selectButton(int index) {
    setState(() {
      for (var i = 0; i < _isSelected.length; i++) {
        // **참(true)**일 때는 현재 인덱스(i)가 클릭된 버튼의 인덱스(index)와 같음
        // **거짓(false)**일 때는 클릭된 버튼이 아니므로 _isSelected[i]를 false로 설정하여 선택되지 않은 상태
        _isSelected[i] = i == index;
      }

      // 선택된 버튼에 따라 AppBar 타이틀 변경
      if (_isSelected[0]) {
        title = "수입";
        title1 = "분류";
        title2 = "자산";
      } else if (_isSelected[1]) {
        title = "지출";
        title1 = "분류";
        title2 = "자산";
      } else if (_isSelected[2]) {
        title = "이체";
        title1 = "출금";
        title2 = "입금";
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // 초기 상태에 현재 날짜와 시간을 지정
    //_dateTimeController.text = formatDateTimeWithDayAndMeridiem(selectDateTime);

    _dateTimeController = TextEditingController(text: widget.fulldate);
    amountController = TextEditingController(text: widget.income.toString());
    classController = TextEditingController(text: widget.category);
    assetController = TextEditingController(text: widget.bank);
    detailController = TextEditingController(text: widget.description);
    id = widget.id;

    _selectButton(1);
  }

  // 날짜와 시간을 "YYYY-MM-DD (요일) 오전/오후 HH:mm" 형식으로 포맷하는 함수
  String formatDateTimeWithDayAndMeridiem(DateTime dateTime) {
    const List<String> koreanWeekdays = ['월', '화', '수', '목', '금', '토', '일'];

    // 요일 설정
    String dayOfWeek = koreanWeekdays[dateTime.weekday - 1];

    // 오전/오후 구분 및 12시간 포맷 설정
    String meridiem = dateTime.hour < 12 ? '오전' : '오후';
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;

    // 날짜와 요일, 시간 문자열 포맷
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ($dayOfWeek) '
        '$meridiem $hour:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // 수입, 지출, 이체 등록 페이지 (날짜 항목)
  Future<void> _selectDateTime(BuildContext context) async {
    // 날짜 선택기 호출
    final DateTime? date = await showDatePicker(
      context: context,

      /// 팝업이 열릴 때 기본적으로 보여줄 날짜
      initialDate: selectDateTime,

      /// 사용자가 선택할 수 있는 날짜의 시작 범위
      firstDate: DateTime(1990),

      /// 사용자가 선택할 수 있는 날짜의 끝 범위
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    // 시간 선택기 호출
    final TimeOfDay? time = await showTimePicker(
      context: context,

      /// 팝업이 열릴 때 기본적으로 보여줄 시간
      initialTime:
          TimeOfDay(hour: selectDateTime.hour, minute: selectDateTime.minute),
    );
    if (time == null) return;

    /// 선택된 날짜와 시간을 결합하여 표시
    setState(() {
      selectDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      /// 새로운 날짜 및 시간 포맷된 문자열로 변환 후 적용
      _dateTimeController.text =
          formatDateTimeWithDayAndMeridiem(selectDateTime);
    });
  }

  Widget _build() {
    return Row(
      children: [
        // 왼쪽 리스트 (카테고리)
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                key:
                    PageStorageKey<String>(categories[index]), // 상태 유지를 위해 키 지정
                title: Text(
                  categories[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index
                        ? Colors.orange
                        : Colors.black, // 선택된 카테고리 색상
                  ),
                ),
                initiallyExpanded: selectedIndex == index, // 선택된 항목 확장
                children: details[categories[index]]!
                    .map(
                      (subcategory) => ListTile(
                        title: Text(subcategory),
                        onTap: () {
                          print("$subcategory 선택됨");
                          // 여기에서 선택에 따라 추가 작업 수행
                        },
                      ),
                    )
                    .toList(),
                onExpansionChanged: (expanded) {
                  if (expanded) {
                    setState(() {
                      selectedIndex = index; // 확장된 카테고리를 선택된 인덱스로 설정
                    });
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            title,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // 이전 화면으로 이동
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 15),
                    // 파랑 파랑 파랑
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectButton(0),
                        style: ButtonStyle(
                          foregroundColor: _isSelected[0]
                              ? WidgetStateProperty.all(Colors.blue.shade300)
                              : WidgetStateProperty.all(Colors.grey.shade600),
                          backgroundColor: _isSelected[0]
                              ? WidgetStateProperty.all(Colors.white)
                              : WidgetStateProperty.all(Colors.grey.shade200),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: _isSelected[0]
                                    ? Colors.blue.shade300
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          textStyle: WidgetStateProperty.all(
                            const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        child: const Text("수입"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // 주황 주황 주황
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectButton(1),
                        style: ButtonStyle(
                          foregroundColor: _isSelected[1]
                              ? WidgetStateProperty.all(Colors.orange.shade900)
                              : WidgetStateProperty.all(Colors.grey.shade600),
                          backgroundColor: _isSelected[1]
                              ? WidgetStateProperty.all(Colors.white)
                              : WidgetStateProperty.all(Colors.grey.shade200),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: _isSelected[1]
                                    ? Colors.orange.shade900
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          textStyle: WidgetStateProperty.all(
                            const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        child: const Text("지출"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // 검정 겅정 검정
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectButton(2),
                        style: ButtonStyle(
                          foregroundColor: _isSelected[2]
                              ? WidgetStateProperty.all(Colors.black)
                              : WidgetStateProperty.all(Colors.grey.shade600),
                          backgroundColor: _isSelected[2]
                              ? WidgetStateProperty.all(Colors.white)
                              : WidgetStateProperty.all(Colors.grey.shade200),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color:
                                    _isSelected[2] ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                          textStyle: WidgetStateProperty.all(
                            const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        child: const Text("이체"),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  child: Row(
                    children: [
                      const SizedBox(width: 18),
                      const Text('날짜'),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 17),
                          child: TextField(
                            controller: _dateTimeController,

                            /// 읽기 전용 (사용자 직접 입력 불가)
                            readOnly: true,

                            /// 날짜 및 시간 선택기 실행
                            onTap: () => _selectDateTime(context),
                            decoration: const InputDecoration(
                              // hintText: '날짜와 시간을 선택하세요',

                              // TextField가 선택되지 않았을 때 나타나는 밑줄 스타일
                              // UnderlineInputBorder로 설정하여 밑줄만 표시
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey), // 기본 밑줄 색상
                              ),

                              /// TextField가 선택되었을 때 나타나는 밑줄 스타일
                              /// UnderlineInputBorder를 사용해 밑줄을 표시
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue), // 포커스 시 밑줄 색상
                              ),
                              //suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(width: 17),
                    const Text(
                      '금액',
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Stack(
                          children: [
                            TextField(
                              inputFormatters: <TextInputFormatter>[
                                CurrencyTextInputFormatter.currency(
                                  locale: 'ko',
                                  decimalDigits: 0,
                                  symbol: '',
                                ),
                              ],
                              // 숫자 자판 표시
                              keyboardType: TextInputType.number,
                              controller: amountController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0, // TextField의 오른쪽 끝에 배치
                              top: 0, // TextField 높이에 맞게 배치
                              child: _isSelected[2]
                                  ? ElevatedButton(
                                      onPressed: () {
                                        print("수수료 버튼 클릭!");
                                      },
                                      style: ButtonStyle(
                                          textStyle: WidgetStateProperty.all(
                                            TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                            Colors.black,
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          padding: WidgetStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                          )),
                                      child: const Text(
                                        "수수료",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(width: 17),
                    Text(
                      title1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: TextField(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      color: Colors.black,
                                      child: Row(
                                        children: [
                                          const Text(
                                            '분류',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ExpenseAdd(),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.pencil,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.xmark,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: _build()),
                                    // SizedBox(
                                    //   height: 300,
                                    //   child: GridView.count(
                                    //     crossAxisCount: 4,
                                    //     crossAxisSpacing: 10,
                                    //     mainAxisSpacing: 10,
                                    //     childAspectRatio: 2,
                                    //     children: <Widget>[
                                    //       _buildCategoryIcon(
                                    //           "식비",
                                    //           Icons.fastfood,
                                    //           '식비 클릭',
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon(
                                    //           "교통/차량",
                                    //           Icons.directions_car,
                                    //           '교통/차량 클릭',
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon(
                                    //           "문화생활",
                                    //           Icons.palette,
                                    //           "문화생활",
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon(
                                    //           "마트/편의점",
                                    //           Icons.local_grocery_store,
                                    //           "마트/편의점",
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon(
                                    //           "패션/미용",
                                    //           Icons.shopping_bag,
                                    //           "패션/미용",
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon("생활용품", Icons.home,
                                    //           "생활용품", classController, context),
                                    //       _buildCategoryIcon(
                                    //           "주거/통신",
                                    //           Icons.phone_android,
                                    //           "주거/통신",
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon(
                                    //           "건강",
                                    //           Icons.health_and_safety,
                                    //           "건강",
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon("교육", Icons.school,
                                    //           "교육", classController, context),
                                    //       _buildCategoryIcon(
                                    //           "경조사/회비",
                                    //           Icons.business,
                                    //           "경조사/회비",
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon(
                                    //           "부모님",
                                    //           Icons.people,
                                    //           "부모님",
                                    //           classController,
                                    //           context),
                                    //       _buildCategoryIcon(
                                    //           "기타",
                                    //           Icons.more_horiz,
                                    //           "기타",
                                    //           classController,
                                    //           context),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          },
                          controller: classController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(width: 17),
                    Text(
                      title2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: TextField(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      color: Colors.black,
                                      child: Row(
                                        children: [
                                          const Text(
                                            '자산',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              CupertinoIcons.pencil,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.xmark,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 250,
                                      child: GridView.count(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 2,
                                        children: <Widget>[
                                          _buildMoney("현금", '식비 클릭',
                                              assetController, context),
                                          _buildMoney("신한은행", '신한은행 클릭',
                                              assetController, context),
                                          _buildMoney("KB국민은행", 'KB국민은행 클릭',
                                              assetController, context),
                                          _buildMoney("기업은행", '기업은행 클릭',
                                              assetController, context),
                                          _buildMoney("카카오뱅크", '카카오뱅크 클릭',
                                              assetController, context),
                                          _buildMoney("농협", '농협 클릭',
                                              assetController, context),
                                          _buildMoney("신한금융", '신한금융 클릭',
                                              assetController, context),
                                          _buildMoney("케이뱅크", '케이뱅크 클릭',
                                              assetController, context),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          controller: assetController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(width: 17),
                    const Text(
                      '내용',
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: TextField(
                          controller: detailController,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                /// 빈 바
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
                const SizedBox(
                  height: 10,
                ),

                /// 메모
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: memoController,
                          decoration: const InputDecoration(
                            hintText: '메모',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            suffixIcon: Icon(
                              Icons.camera_alt_outlined,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                // 삭제
                Row(
                  children: [
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 210,
                      child: Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // 메세지 박스 표출
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  // Dialog 타이틀
                                  title: Text('확인'),
                                  content: Text('정말로 데이터를 삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        '취소',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        try {
                                          ApiService.deleteData(id)
                                              .then((response) {
                                            print("Data delete successfully");
                                            // 성공하면 물어보는 메세지 박스 닫음
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('삭제완료'),
                                                  content: Text(
                                                      '데이터가 성공적으로 삭제되었습니다.'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/main');
                                                      },
                                                      child: Text(
                                                        '확인',
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          }).catchError((error) {
                                            print("Error occurred: $error");
                                          });
                                        } catch (e) {
                                          print("Exception caught: $e");
                                        }
                                      },
                                      child: Text(
                                        '확인',
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.red),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          child: const Text(
                            '삭제',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('수정'),
                                content: Text('해당 데이터를 수정하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      '취소',
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        String Date = _dateTimeController.text;
                                        String Amount = amountController.text;
                                        String Class = classController.text;
                                        String Asset = assetController.text;
                                        String Detail = detailController.text;
                                        String Memo = memoController.text;

                                        try {
                                          String date = _dateTimeController.text
                                              .substring(0, 10);
                                          String dayOfWeek =
                                              '${_dateTimeController.text.substring(12, 13)}요일';
                                          String category =
                                              classController.text;
                                          String description =
                                              detailController.text;
                                          String time = _dateTimeController.text
                                              .substring(15, 22);
                                          String bank = assetController.text;

                                          ApiService.updateDate(
                                                  id: id,
                                                  date: _dateTimeController.text
                                                      .substring(8, 10),
                                                  dayOfWeek:
                                                      '${_dateTimeController.text.substring(12, 13)}요일',
                                                  category: Class,
                                                  description: Detail,
                                                  time: _dateTimeController.text
                                                      .substring(15, 22),
                                                  bank: Asset,
                                                  income: 0,
                                                  expense: 0,
                                                  fulldate:
                                                      _dateTimeController.text)
                                              .then((response) {
                                            print("Data Update successfully");
                                            Navigator.of(context).pop();
                                            // 업데이트 성공 시 메세지 박스 띄우기
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('수정완료'),
                                                  content: Text(
                                                      '데이터가 성공적으로 수정되었습니다.'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/main');
                                                      },
                                                      child: Text(
                                                        '확인',
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          }).catchError((error) {
                                            print("Error occurred: $error");
                                          });
                                        } catch (e) {
                                          print("Exception caught: $e");
                                        }
                                      },
                                      child: Text('확인'))
                                ],
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.black),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          '수정',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCategoryIcon(String label, IconData iconData, String Click,
    TextEditingController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      controller.text = label;
      print(Click);
      Navigator.of(context).pop();
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 20,
            color: Colors.blue,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMoney(String label, String Click, TextEditingController controller,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      controller.text = label;
      print(Click);
      Navigator.of(context).pop();
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
    ),
  );
}
