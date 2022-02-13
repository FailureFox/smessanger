import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerViewPage extends StatefulWidget {
  final String url;
  const TrailerViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _TrailerViewPageState createState() => _TrailerViewPageState();
}

class _TrailerViewPageState extends State<TrailerViewPage> {
  late final YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: widget.url,
        flags: const YoutubePlayerFlags(
          disableDragSeek: true,
          autoPlay: false,
          isLive: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      controller: controller,
      progressColors: ProgressBarColors(
          backgroundColor: Colors.white,
          handleColor: Theme.of(context).colorScheme.primary,
          playedColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          bufferedColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.5)),
    );
    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Trailer',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: player,
        );
      },
    );
  }
}
