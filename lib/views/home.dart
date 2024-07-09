import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playhits/consts/colors.dart';

import 'package:playhits/consts/text_style.dart';
import 'package:playhits/controller/player_controller.dart';
import 'package:playhits/views/music_list.dart';
import 'package:playhits/views/player.dart';
import 'package:playhits/views/playlist_tab.dart';
import 'package:playhits/widgets/bottom_music_player.dart';

class Home extends StatefulWidget {
  Home({super.key});
  final PlayerController playerController = Get.put(PlayerController());
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
        child: Stack(
          children: [
            DefaultTabController(
              length: 4,
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
                            Tab(text: "All Songs"),
                            Tab(text: "Playlists"),
                            Tab(text: "Favourites"),
                            Tab(text: "Trending"),
                          ]),
                      const Flexible(
                          child: TabBarView(
                        children: [
                          MusicList(),
                          PLaylist(),
                          Center(
                            child: Text(
                              "Development in progress,Will be available soon!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Development in progress,Will be available soon!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomMusicPlayerWidget(),
    );
  }
}
