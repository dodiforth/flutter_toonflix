import 'package:flutter/material.dart';

import 'package:flutter_toon/services/api_service.dart';
import 'package:flutter_toon/models/webtoon_detail.dart';
import 'package:flutter_toon/models/webtoon_episode.dart';

class SingleWebtoonScreen extends StatefulWidget {
  final String title, thumb, id;

  const SingleWebtoonScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  State<SingleWebtoonScreen> createState() => _SingleWebtoonScreenState();
}

class _SingleWebtoonScreenState extends State<SingleWebtoonScreen> {
  late Future<WebtoonDetailModel> webtoonDetail;

  late Future<List<WebtoonEpisodeModel>> latestEpisodes;

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiServices.getWebtoonById(widget.id);
    latestEpisodes = ApiServices.getLatestEpisodeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.green[500],
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: widget.id,
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
                        child: Image.network(
                          widget.thumb,
                          headers: const {
                            'Referer': 'https://comic.naver.com',
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: webtoonDetail,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.about,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${snapshot.data!.genre} / ${snapshot.data!.age}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            )
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
                    }),
                FutureBuilder(
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
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 94, 163, 96),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: const Offset(0, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          trailing: const Icon(
                                              Icons.chevron_right,
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
                                          onTap: () {
                                            // Add your logic here
                                          },
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
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
