import 'package:flutter/material.dart';
import 'package:cf_youtude/component/custom_youtube_player.dart';
import 'package:cf_youtude/model/video_model.dart';
import 'package:cf_youtude/repository/youtube_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('dd'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: snapshot.data!
                  .map((e) => CustomYoutubePlayer(videoModel: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
