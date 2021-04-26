// import 'package:flutter/material.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:video_player/video_player.dart';
//
// class CustomPlayer extends StatefulWidget {
//   final String url;
//   final String videoTitle;
//   final String thumbImage;
//   CustomPlayer({Key key,this.url,this.thumbImage,this.videoTitle}) : super(key: key);
//
//   @override
//   _CustomPlayerState createState() => _CustomPlayerState();
// }
//
// class _CustomPlayerState extends State<CustomPlayer> {
//   FlickManager flickManager;
//   @override
//   void initState() {
//     super.initState();
//     print(widget.videoTitle);
//     print(widget.url);
//     print(widget.thumbImage);
//     flickManager = FlickManager(
//       videoPlayerController:
//       VideoPlayerController.network(widget.url),
//     );
//   }
//
//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         print(widget.url);
//       },
//       child: Container(
//         child: FlickVideoPlayer(
//             flickManager: flickManager,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final bool play;

  const VideoWidget({Key key, @required this.url, @required this.play})
      : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}

class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          children: List.generate(
            30,
                (index) {
              return Container(
                width: double.infinity,
                height: 300.0,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 50.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final InViewState inViewState =
                    InViewNotifierList.of(context);

                    inViewState.addContext(context: context, id: '$index');

                    return AnimatedBuilder(
                      animation: inViewState,
                      builder: (BuildContext context, Widget child) {
                        return VideoWidget(
                            play: inViewState.inView('$index'),
                            url:
                            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 1.0,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: VideoList()),
          ],
        ),
      ),
    );
  }
}