import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_toon/models/webtoon_episode.dart';

class Episodes extends StatelessWidget {
  const Episodes({
    super.key,
    required this.latestEpisodes,
    required this.episodeId,
  });

  final Future<List<WebtoonEpisodeModel>> latestEpisodes;
  final String episodeId;

  onButtonTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$latestEpisodes&no=$episodeId");
    await launchUrl(url);
  }
  //https://comic.naver.com/webtoon/detail?titleId=648419&no=423

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: latestEpisodes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final episode = snapshot.data![index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 94, 163, 96),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: ListTile(
                              trailing: const Icon(Icons.chevron_right,
                                  color: Colors
                                      .white), // Add the chevron icon as the leading widget with white color
                              title: Text(
                                episode.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(episode.date),
                              onTap: onButtonTap,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
                'Error: ${snapshot.error} hey there! we can\t load the data!'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      },
    );
  }
}
