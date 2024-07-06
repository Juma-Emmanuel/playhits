import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playhits/consts/colors.dart';

import 'package:playhits/consts/text_style.dart';
import 'package:playhits/controller/player_controller.dart';
import 'package:playhits/views/music_list.dart';
import 'package:playhits/views/player.dart';
import 'package:playhits/views/playlist_tab.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFF303151).withOpacity(0.6),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text(
            'PlayHits',
            style: textStyles(size: 18, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: whiteColor,
                ))
          ],
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 6,
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    const Color(0xFF303151).withOpacity(0.6),
                    const Color(0xFF303151).withOpacity(0.9)
                  ])),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF31314F)),
                      height: 50,
                      width: screenWidth * 0.95,
                      child: TextFormField(
                          decoration: InputDecoration(
                              suffixIconConstraints: const BoxConstraints(
                                maxHeight: 20,
                                minWidth: 25,
                              ),
                              hintText: "Search......",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                              border: InputBorder.none)),
                    ),
                    const TabBar(
                        labelColor: whiteColor,
                        unselectedLabelColor: Colors.white54,
                        isScrollable: true,
                        labelStyle: TextStyle(fontSize: 18),
                        indicator: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 3, color: Color(0xFF899CCF)))),
                        tabs: [
                          Tab(text: "Musics"),
                          Tab(text: "Playlists"),
                          Tab(text: "Favourites"),
                          Tab(text: "Trending"),
                          Tab(text: "Collections"),
                          Tab(text: "New")
                        ]),
                    Flexible(
                        child: TabBarView(
                      children: [
                        MusicList(),
                        PLaylist(),
                        Container(
                          color: Colors.blueAccent,
                        ),
                        Container(
                          color: Colors.blueAccent,
                        ),
                        Container(
                          color: Colors.blueAccent,
                        ),
                        Container(
                          color: Colors.blueAccent,
                        ),
                      ],
                    ))
                    // FutureBuilder(
                    //     future: controller.audioQuery.querySongs(
                    //       ignoreCase: true,
                    //       orderType: OrderType.ASC_OR_SMALLER,
                    //       sortType: null,
                    //       uriType: UriType.EXTERNAL,
                    //     ),
                    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //       if (snapshot.data == null) {
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       } else if (snapshot.data!.isEmpty) {
                    //         return Text(
                    //           "No Song ",
                    //           style: textStyles(
                    //               color: const Color.fromARGB(255, 7, 56, 139)),
                    //         );
                    //       } else {
                    //         return Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Container(
                    //             child: ListView.builder(
                    //                 physics: const BouncingScrollPhysics(),
                    //                 itemCount: snapshot.data.length,
                    //                 itemBuilder: (BuildContext context, index) {
                    //                   return Container(
                    //                     margin: EdgeInsets.only(bottom: 4),
                    //                     child: ListTile(
                    //                       shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(12),
                    //                       ),
                    //                       tileColor: bgColor,
                    //                       title: Text(
                    //                         snapshot
                    //                             .data![index].displayNameWOExt,
                    //                         overflow: TextOverflow.ellipsis,
                    //                         maxLines: 2,
                    //                         style: textStyles(size: 15),
                    //                       ),
                    //                       subtitle: Text(
                    //                         snapshot.data![index].artist,
                    //                         overflow: TextOverflow.ellipsis,
                    //                         maxLines: 1,
                    //                         style: textStyles(size: 12),
                    //                       ),
                    //                       leading: QueryArtworkWidget(
                    //                         id: snapshot.data![index].id,
                    //                         type: ArtworkType.AUDIO,
                    //                         nullArtworkWidget: const Icon(
                    //                             Icons.music_note,
                    //                             color: whiteColor,
                    //                             size: 32),
                    //                       ),
                    //                       trailing: controller.playIndex.value ==
                    //                                   index &&
                    //                               controller.isPlaying.value
                    //                           ? const Icon(Icons.play_arrow,
                    //                               color: whiteColor, size: 26)
                    //                           : null,
                    //                       onTap: () {
                    //                         controller.playSong(
                    //                             snapshot.data![index].uri, index);
                    //                         Navigator.push(
                    //                           context,
                    //                           MaterialPageRoute(
                    //                             builder: (context) =>
                    //                                 Player(data: snapshot.data!),
                    //                           ),
                    //                         );
                    //                         // Get.to(() => const Player());
                    //                       },
                    //                     ),
                    //                   );
                    //                 }),
                    //           ),
                    //         );
                    //       }
                    //     }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
