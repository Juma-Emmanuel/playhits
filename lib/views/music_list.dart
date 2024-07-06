import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playhits/consts/colors.dart';
import 'package:playhits/consts/text_style.dart';
import 'package:playhits/controller/player_controller.dart';
import 'package:playhits/views/music_player.dart';
import 'package:playhits/views/player.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  var controller = Get.put(PlayerController());
  bool _permissionsGranted = false;

  @override
  void initState() {
    super.initState();
    reqPermission();
  }

  void reqPermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      setState(() {
        _permissionsGranted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: _permissionsGranted
            ? FutureBuilder<List<SongModel>>(
                future: controller.audioQuery.querySongs(
                  ignoreCase: true,
                  orderType: OrderType.ASC_OR_SMALLER,
                  sortType: null,
                  uriType: UriType.EXTERNAL,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: textStyles(
                            color: const Color.fromARGB(255, 7, 56, 139)),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No Songs Found',
                        style: textStyles(
                            color: const Color.fromARGB(255, 7, 56, 139)),
                      ),
                    );
                  } else {
                    controller.setPlaylistFromQuery(snapshot.data!);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.playAll();
                            },
                            child: Container(
                              width: screenWidth * 0.4,
                              height: screenWidth * 0.11,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Play All",
                                    style: TextStyle(
                                        color: Color(0xFF30314D),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: Color(0xFF30314D),
                                    size: 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var song = snapshot.data![index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    tileColor: Color(0xFF31314F),
                                    title: Text(
                                      song.displayNameWOExt,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: textStyles(size: 15),
                                    ),
                                    subtitle: Text(
                                      song.artist ?? 'Unknown Artist',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: textStyles(size: 12),
                                    ),
                                    leading: QueryArtworkWidget(
                                      id: song.id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: const Icon(
                                          Icons.music_note,
                                          color: whiteColor,
                                          size: 32),
                                    ),
                                    onTap: () {
                                      controller.playSong(
                                          snapshot.data![index].uri, index);
                                      // controller.playSongFromPlaylist(index);
                                      // Get.to(() => Player(data: snapshot.data!));
                                      Get.to(() =>
                                          MusicPlayer(data: snapshot.data!));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            : Center(
                child: Text(
                  'Permissions not granted',
                  style:
                      textStyles(color: const Color.fromARGB(255, 7, 56, 139)),
                ),
              ),
      ),
    );
  }
}