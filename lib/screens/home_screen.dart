import 'package:flutter/material.dart';
import 'package:flutter_toon/models/webtoon.dart';
import 'package:flutter_toon/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    webtoons = await ApiServices.getTodayWebtoons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Material(
          elevation: 7.0,
          shadowColor: Colors.grey, // change this to your desired color
          child: AppBar(
            title: const Text(
              'Today\'s NAVER Webtoons',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            foregroundColor: Colors.green[500],
            backgroundColor:
                Colors.white, // change this to your desired AppBar color
          ),
        ),
      ),
    );
  }
}
