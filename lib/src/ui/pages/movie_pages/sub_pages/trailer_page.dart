import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerViewPage extends StatefulWidget {
  final List<String> url;
  const TrailerViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _TrailerViewPageState createState() => _TrailerViewPageState();
}

class _TrailerViewPageState extends State<TrailerViewPage> {
  late YoutubePlayerController controller;

  int page = 0;
  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      initialVideoId: widget.url[0],
      flags: const YoutubePlayerFlags(
        disableDragSeek: true,
        autoPlay: false,
        isLive: false,
      ),
    );
  }

  void changeTrailer(int trailer) {
    page = trailer;
    setState(() {});
    controller.load(widget.url[page]);
    
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        progressColors: ProgressBarColors(
            backgroundColor: Colors.white,
            handleColor: Theme.of(context).colorScheme.primary,
            playedColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            bufferedColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.5)),
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Trailer',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(),
              player,
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                  widget.url.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.square(
                      dimension: MediaQuery.of(context).size.width / 11,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          onPressed: page == index
                              ? null
                              : () {
                                  changeTrailer(index);
                                },
                          child: Text('${index + 1}')),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
