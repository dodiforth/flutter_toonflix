import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_toon/screens/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  final String title, thumb, id;

  const WebtoonWidget(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    return Column(
      children: [
        Hero(
          tag: id,
          child: Container(
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    fullscreenDialog: true,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return SingleWebtoonScreen(
                          title: title, thumb: thumb, id: id);
                    },
                  ),
                );
                logger.i('WebtoonWidget: $id');
              },
              child: Image.network(
                thumb,
                headers: const {
                  'Referer': 'https://comic.naver.com',
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(title,
            style: GoogleFonts.notoSans(
              textStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            )),
      ],
    );
  }
}
