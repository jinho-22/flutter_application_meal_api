import 'package:flutter/material.dart';
import 'package:flutter_application_meal_api/neis_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  dynamic body = const Text('날짜를 검색하세요');
  void showCal() async {
    var dt = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2023, 3, 2),
        lastDate: DateTime(2023, 7, 30));

    if (dt != null) {
      var tempDate = dt.toString().split(' ');
      String startDate = tempDate[0].replaceAll('-', '');
      String endDate = tempDate[3].replaceAll('-', '');
      var neisApi = NeisApi();
      var meals =
          neisApi.getMeal(MLSV_FROM_YMD: startDate, MLSV_TO_YMD: endDate);

      setState(() {
        body = ListView.separated(
            itemBuilder: (context, index) {
              return Text(meals[index]['DDISH_NM']);
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: meals.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
          onPressed: showCal, child: const Icon(Icons.calendar_month)),
    );
  }
}
