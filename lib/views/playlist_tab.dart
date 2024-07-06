import 'package:flutter/material.dart';
import 'package:playhits/widgets/playlist_listtile.dart';

class PLaylist extends StatefulWidget {
  const PLaylist({super.key});

  @override
  State<PLaylist> createState() => _PLaylistState();
}

class _PLaylistState extends State<PLaylist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return PlayListTile();
                }),
          ),
        ),
      ),
    );
  }
}
