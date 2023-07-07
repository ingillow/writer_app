import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../controller/settings_app_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsAppController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings page'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    settings.getImageWallper();
                  },
                  child: Text('Use wallpapers',  style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 14),)),
              Image.asset(
                settings.imagePath,
                width: 70,
                height: 70,
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Choose a background color, \nby tapping on it',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => settings.changeByRandomColor(),
                child: Container(
                  width: 70,
                  height: 70,
                  color: settings.color,
                ),
              )
            ],
          ),
          Text('Your wholesome statistic'),
         // WholesomeStatistics()
        ],
      ),
    );
  }
}


class WholesomeStatistics extends StatefulWidget {
  @override
  _WholesomeStatisticsState createState() => _WholesomeStatisticsState();
}

class _WholesomeStatisticsState extends State<WholesomeStatistics> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<WordCount> _wordCounts = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textEditingController,
                onChanged: (value) {
                  setState(() {
                    final currentDateTime = DateTime.now();
                    final currentDay = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day);
                    final currentMonth = DateTime(currentDateTime.year, currentDateTime.month);
                    final wordCount = WordCount(
                      day: currentDay,
                      month: currentMonth,
                      count: _countWords(value),
                    );
                    _wordCounts.add(wordCount);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter text',
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: charts.TimeSeriesChart(
                  _createSeriesData(),
                  animate: true,
                  defaultRenderer: charts.BarRendererConfig(
                    cornerStrategy: const charts.ConstCornerStrategy(30),
                    groupingType: charts.BarGroupingType.grouped,
                    strokeWidthPx: 2.0,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  List<charts.Series<WordCount, DateTime>> _createSeriesData() {
    final dailyData = _aggregateWordCountsByDay();
    final monthlyData = _aggregateWordCountsByMonth();

    return [
      charts.Series<WordCount, DateTime>(
        id: 'Words per Day',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WordCount wordCount, _) => wordCount.day,
        measureFn: (WordCount wordCount, _) => wordCount.count,
        data: dailyData,
      ),
      charts.Series<WordCount, DateTime>(
        id: 'Words per Month',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (WordCount wordCount, _) => wordCount.month,
        measureFn: (WordCount wordCount, _) => wordCount.count,
        data: monthlyData,
      ),
    ];
  }

  List<WordCount> _aggregateWordCountsByDay() {
    final Map<DateTime, int> wordCountsByDay = {};

    for (final wordCount in _wordCounts) {
      final day = wordCount.day;
      wordCountsByDay[day] = (wordCountsByDay[day] ?? 0) + wordCount.count;
    }

    return wordCountsByDay.entries.map((entry) => WordCount(day: entry.key, count: entry.value, month: entry.key)).toList()
      ..sort((a, b) => a.day.compareTo(b.day));
  }

  List<WordCount> _aggregateWordCountsByMonth() {
    final Map<DateTime, int> wordCountsByMonth = {};

    for (final wordCount in _wordCounts) {
      final month = wordCount.month;
      wordCountsByMonth[month] = (wordCountsByMonth[month] ?? 0) + wordCount.count;
    }

    return wordCountsByMonth.entries.map((entry) => WordCount(month: entry.key, count: entry.value, day: entry.key)).toList()
      ..sort((a, b) => a.month.compareTo(b.month));
  }

  int _countWords(String text) {
    if (text.isEmpty) return 0;

    final words = text.split(' ');
    return words.length;
  }
}

class WordCount {
  final DateTime day;
  final DateTime month;
  final int count;

  WordCount({required this.day, required this.month, required this.count});
}
