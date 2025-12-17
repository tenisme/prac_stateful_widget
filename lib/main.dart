import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

// State 클래스는 데이터를 가지고 있으며, UI를 그리는 역할도 한다.
// 데이터가 바뀌는 동시에 위젯도 업데이트 되며, UI 또한 그에 맞게 새로고침된다.
class _AppState extends State<App> {
  // '데이터' 역할을 하는 '상태' 변수 선언
  // counter라는 속성을(property를) 가지고 있는 평범한 Dart class.
  int counter = 0;

  // List<int>형 데이터 상태 변수 예시
  // List<int> numbers = [];

  bool showTitle = true;

  void toggleTitle() {
    setState(() {
      // showTitle이 true면 false로, false면 true로 바꾼다.
      showTitle = !showTitle;
    });
  }

  void onClicked() {
    // setState() 메서드는 State 클래스에 정의된 메서드로,
    // 이 메서드 안에서 상태 변화를 일으키면 Flutter가 UI를 다시 그리도록 한다.
    setState(() {
      // counter = counter + 1; 과 같다.
      counter++;

      // numbers.add(numbers.length);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          // large title의 스타일을 정의함
          titleLarge: TextStyle(color: Colors.red[300]),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이 MyLargeTitle()가 위치한 곳에서 최상위 부모는 _AppState 위젯이다.
              // showTitle이 false가 되면 MyLargeTitle 위젯이 위젯 트리에서 '제거(dispose())'된다.
              showTitle
                  ? MyLargeTitle()
                  : Text("Nothing", style: TextStyle(fontSize: 30)),
              Text("$counter", style: TextStyle(fontSize: 30)),
              // for (var n in numbers.reversed) Text("$n"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 50,
                    // 클릭할 때마다 실행될 함수를 onPressed에 할당한다.
                    // onPressed에는 즉시 실행(onClicked())이 아닌 함수 참조(onClicked)를 전달해야 한다.
                    onPressed: onClicked,
                    // 버튼 아이콘 디자인을 지정한다.
                    icon: Icon(Icons.add_box_rounded),
                  ),
                  IconButton(
                    iconSize: 50,
                    onPressed: toggleTitle,
                    icon: Icon(Icons.remove_red_eye),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({super.key});

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  // 위젯 생성 시 단 한 번, build보다 먼저 실행되는 메서드.
  // 단순 변수 초기화(initialize)보다는 '부모 데이터 의존' 값이나 API 등을 초기화하는 데에 주로 사용한다.
  // 제거(dispose()) 될 때까지 단 한 번만 호출된다. 그 말인 즉 위젯이 새롭게 만들어지면 initState()가 다시 호출된다는 뜻이다.
  @override
  void initState() {
    super.initState(); // super.initState()는 코드 블럭 내부에서 반드시 제일 먼저 호출해야 한다.
    debugPrint("MyLargeTitle - initState()");
  }

  // 위젯이 위젯 트리에서 완전히 제거되기 전에 실행되는 메서드.
  // 무언가를 Clean-up(취소, 해제)하고 싶을 때 이 메서드를 사용한다.
  // 이미 위젯이 파괴되는(취소되는) 중이므로 내부에서 setState를 호출하면 절대 안 됨.
  // 위젯이 dispose()된 후에는 다시 build()가 실행되지 않는다.
  @override
  void dispose() {
    super.dispose(); // super.dispose()는 코드 블럭 내부에서 반드시 제일 마지막에 호출해야 한다.
    debugPrint("MyLargeTitle - dispose()");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("MyLargeTitle - build()");
    return Text(
      "Click Count",
      style: TextStyle(
        fontSize: 30,
        // context, 즉 이 위젯이 위치한 곳(위젯 트리)에서 상위 부모의 테마를 참조하여 색상을 지정한다.
        // 'titleLarge의 값은 반드시 null이 아니다'라는 것을 알려주기 위해 단언 연산자(!)로 명시한다.
        color: Theme.of(context).textTheme.titleLarge!.color,
      ),
    );
  }
}
