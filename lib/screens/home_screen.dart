import 'package:flutter/material.dart';
import 'package:flutter_toon/models/webtoon.dart';
import 'package:flutter_toon/services/api_service.dart';

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
            print(snapshot.data![0].thumb);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                print(index);
                return Text(snapshot.data![index].title);
                // return SizedBox(
                //   width: 100,
                //   child: Column(
                //     children: [
                //       Image.network(
                //         snapshot.data![index].thumb,
                //         width: 100,
                //         height: 100,
                //         fit: BoxFit.cover,
                //       ),
                //       Text(snapshot.data![index].title),
                //     ],
                //   ),
                // );
                // return ListTile(
                //   // leading: Image.network(snapshot.data![index].thumb),
                //   // leading: Image.network(
                //   //   snapshot.data![index].thumb,
                //   //   width: 100,
                //   //   height: 100,
                //   //   fit: BoxFit.cover,
                //   // ),

                //   title: Text(snapshot.data![index].title),
                // );
              },
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
}
