import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playhits/lists/playlist_tracks.dart';
import 'package:playhits/widgets/bottom_music_player.dart';
import 'package:playhits/widgets/playlist_listtile.dart';

class PLaylistView extends StatefulWidget {
  const PLaylistView({super.key});

  @override
  State<PLaylistView> createState() => _PLaylistViewState();
}

class _PLaylistViewState extends State<PLaylistView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            const Color(0xFF303151).withOpacity(0.6),
            const Color(0xFF303151).withOpacity(0.9)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Color(0xFF899CCF),
                      size: 30,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      color: Color(0xFF899CCF),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/headphone.jpg",
                width: screenWidth * 0.6,
                height: screenWidth * 0.6,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Text(
                  "Imagine Dragons",
                  style: TextStyle(
                      fontSize: 28, color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Singer Name",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white.withOpacity(0.8)),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {},
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
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: screenWidth * 0.4,
                    height: screenWidth * 0.11,
                    decoration: BoxDecoration(
                        color: const Color(0xFF30314D),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Shuffle",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.shuffle,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const PlaylistTracks(),
          ],
        )),
        bottomNavigationBar: const BottomMusicPlayerWidget(),
      ),
    );
  }
}
