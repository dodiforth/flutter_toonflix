import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class WebtoonWidget extends StatelessWidget {
  final String title, thumb, id;

  const WebtoonWidget(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
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
            thumb,
            headers: const {
              'Referer': 'https://comic.naver.com',
            },
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
