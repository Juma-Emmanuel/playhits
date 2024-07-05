import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playhits/consts/colors.dart';

import 'package:playhits/consts/text_style.dart';
import 'package:playhits/controller/player_controller.dart';
import 'package:playhits/views/player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          leading: const Icon(
            Icons.sort_rounded,
            color: bgColor,
          ),
          title: Text(
            'PlayHits',
            style: textStyles(
                size: 18, color: const Color.fromARGB(255, 7, 56, 139)),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL,
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Text(
                    "No Song ",
                    style: textStyles(
                        color: const Color.fromARGB(255, 7, 56, 139)),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                tileColor: bgColor,
                                title: Text(
                                  snapshot.data![index].displayNameWOExt,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: textStyles(size: 15),
                                ),
                                subtitle: Text(
                                  snapshot.data![index].artist,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textStyles(size: 12),
                                ),
                                leading: QueryArtworkWidget(
                                  id: snapshot.data![index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(
                                      Icons.music_note,
                                      color: whiteColor,
                                      size: 32),
                                ),
                                trailing: controller.playIndex.value == index &&
                                        controller.isPlaying.value
                                    ? const Icon(Icons.play_arrow,
                                        color: whiteColor, size: 26)
                                    : null,
                                onTap: () {
                                  controller.playSong(
                                      snapshot.data![index].uri, index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Player(data: snapshot.data!),
                                    ),
                                  );
                                  // Get.to(() => const Player());
                                },
                              ),
                            );
                          }),
                    ),
                  );
                }
              }),
        ));
  }
}
