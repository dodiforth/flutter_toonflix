import 'package:flutter/material.dart';
import 'package:flutter_toon/models/webtoon.dart';
import 'package:flutter_toon/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Future<List<WebtoonModel>> getWebtoons() async {
  //   return await ApiServices.getTodayWebtoons();
  // }
  final Future<List<WebtoonModel>> webtoons = ApiServices.getTodayWebtoons();

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<WebtoonModel>>(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(1),
                    offset: const Offset(1.0, 5.0),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Image.network(
                snapshot.data![index].thumb,
                headers: const {
                  'Referer': 'https://comic.naver.com',
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(snapshot.data![index].title,
                style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}
