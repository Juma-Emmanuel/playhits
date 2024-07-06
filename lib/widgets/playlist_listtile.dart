import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playhits/consts/text_style.dart';
import 'package:playhits/views/playlist.dart';

class PlayListTile extends StatelessWidget {
  const PlayListTile({super.key, this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Color(0xFF31314F),
        title: const Text(
          "Country Music",
          // "data.playlistName",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: const Text(
          // "data.tracksLength",
          "105 tracks",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/headphone.jpg",
            fit: BoxFit.cover,
            height: 60,
            width: 60,
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
          Get.to(() => PLaylistView(
              // data: snapshot.data!
              ));
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         Player(data: snapshot.data!),
          //   ),
          // );
        },
      ),
    );
  }
}
