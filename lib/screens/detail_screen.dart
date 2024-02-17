import 'package:flutter/material.dart';

class SingleWebtoonScreen extends StatelessWidget {
  final String title, thumb, id;

  const SingleWebtoonScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.green[500],
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    thumb,
                    headers: const {
                      'Referer': 'https://comic.naver.com',
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
