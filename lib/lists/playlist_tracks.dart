import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playhits/consts/text_style.dart';
import 'package:playhits/views/music_player.dart';
import 'package:playhits/widgets/playlist_listtile.dart';

class PlaylistTracks extends StatefulWidget {
  const PlaylistTracks({super.key});

  @override
  State<PlaylistTracks> createState() => _PlaylistTracksState();
}

class _PlaylistTracksState extends State<PlaylistTracks> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: const Color(0xFF31314F),
                      title: const Text(
                        "song.displayNameWOExt",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Justin Timberlake",
                        // song.artist ?? 'Unknown Artist',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      leading: const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          )),
                      onTap: () {
                        // controller.playSong(
                        //     snapshot.data![index].uri, index);
                        // Get.to(() => MusicPlayer());
                        // Navigator.pushNamed(context, "musicplayer");
                      },
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
