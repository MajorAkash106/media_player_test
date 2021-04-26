import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:furmous/res/colors.dart';
// import 'package:furmous/views/addpost/add_Post.dart';
// import 'package:furmous/utils/my_extensions.dart';
// import 'package:video_player/video_player.dart';

class AllMediaWidget extends StatefulWidget {
  // FileType type;
  String path;
  String thumbnailForVideo;
  final double ratio;
  bool wantPlayerController = true;

  AllMediaWidget(
      {
        // this.type,
        this.ratio = 1,
        this.path,
        this.thumbnailForVideo,
        this.wantPlayerController = true});

  @override
  _AllMediaWidgetState createState() => _AllMediaWidgetState();
}

class _AllMediaWidgetState extends State<AllMediaWidget> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    print("File path: ${widget.path}");
    print("File path: ${widget.thumbnailForVideo}");
    // print("File path: ${widget.type}");
    print("File path: ${widget.ratio}");

    BetterPlayerDataSource betterPlayerDataSource;
    betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.NETWORK, widget.path);

    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            fit: BoxFit.cover,
            aspectRatio: widget.ratio,autoPlay: false,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              showControls: widget.wantPlayerController,
                enableProgressBar: true,
              // progressBarBackgroundColor: Colors.white,
              progressBarBufferedColor: Colors.white,
              showControlsOnInitialize: false,
              // enablePip: true,
              // enableSkips: false,
              // loadingWidget: SizedBox.shrink()
            )),
        betterPlayerDataSource: betterPlayerDataSource);
    // videoPlayerController1.setLooping(true);
    _betterPlayerController.addEventsListener((e) {
      // playerState = e.betterPlayerEventType;
      print("playerState: ${e.betterPlayerEventType}");

      if (e.betterPlayerEventType == BetterPlayerEventType.FINISHED) {
        setState(() {
          _betterPlayerController.seekTo(Duration(milliseconds: 0));
          _betterPlayerController.pause();
        });
      }
    });

    // if (widget.type == FileType.video) {
    //   BetterPlayerDataSource betterPlayerDataSource;
      // if (widget.path.startsWith("http") || widget.path.startsWith("https")) {
      //   betterPlayerDataSource = BetterPlayerDataSource(
      //       BetterPlayerDataSourceType.network, widget.path);
      //   // videoPlayerController1 = VideoPlayerController.network(widget.path);
      //   // _initializeVideoPlayerFuture = videoPlayerController1.initialize();
      // } else {
      //   betterPlayerDataSource = BetterPlayerDataSource(
      //       BetterPlayerDataSourceType.file, widget.path);
      //   // videoPlayerController1 = VideoPlayerController.file(File(widget.path));
      //   // _initializeVideoPlayerFuture = videoPlayerController1.initialize();
      // }

      // _betterPlayerController = BetterPlayerController(
      //     BetterPlayerConfiguration(
      //         fit: BoxFit.cover,
      //         aspectRatio: widget.ratio,
      //         controlsConfiguration: BetterPlayerControlsConfiguration(
      //             showControls: widget.wantPlayerController,
      //             showControlsOnInitialize: false,
      //             // enablePip: true,
      //             // enableSkips: false,
      //             // loadingWidget: SizedBox.shrink()
      //         )),
      //     betterPlayerDataSource: betterPlayerDataSource);
      // // videoPlayerController1.setLooping(true);
      // _betterPlayerController.addEventsListener((e) {
      //   // playerState = e.betterPlayerEventType;
      //   print("playerState: ${e.betterPlayerEventType}");
      //
      //   if (e.betterPlayerEventType == BetterPlayerEventType.finished) {
      //     setState(() {
      //       _betterPlayerController.seekTo(Duration(milliseconds: 0));
      //       _betterPlayerController.pause();
      //     });
      //   }
      // });
    // }

    print("File path: ${widget.path}");

    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController?.dispose();
    super.dispose();
  }

 bool _isplayingg =false ;
  Future isplaying()async{
    bool isplaying =await _betterPlayerController.isPlaying();
    setState(() {
      _isplayingg = isplaying;
    });
    // return isplaying;
  }

  @override
  Widget build(BuildContext context) {
    isplaying();
   // return Expanded(
   //   child: CachedNetworkImage(
   //     fit: BoxFit.cover,
   //     imageUrl: "${widget.thumbnailForVideo}",
   //     progressIndicatorBuilder:
   //         (context, url, downloadProgress) => Container(
   //       child: Center(
   //         child: SizedBox(
   //             height: 10,
   //             width: 10,
   //             child: CircularProgressIndicator(
   //                 value: downloadProgress.progress)),
   //       ),
   //     ),
   //     errorWidget: (context, url, error) =>
   //         Icon(Icons.error),
   //   ),
   // );
    return Stack(
    children: [
      BetterPlayer(
        controller: _betterPlayerController,
      ),
      _isplayingg?
          SizedBox()
     : Positioned.fill(
       child:widget.thumbnailForVideo!=null? CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: "${widget.thumbnailForVideo}",
          progressIndicatorBuilder:
              (context, url, downloadProgress) => Container(
            child: Center(
              child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress)),
            ),
          ),
          errorWidget: (context, url, error) =>
              Icon(Icons.error),
        ):SizedBox(),
     ),
     Positioned(
       top: 0,bottom: 0,left: 0,right: 0,
       child:  Align(
           alignment: Alignment.center,
           child: playPauseBtn()),)
    ],
    );

  }

  Widget playPauseBtn() {
    return InkWell(
      onTap: ()async {
        print('thumnail:${widget.thumbnailForVideo}');
        print('thumnail:${widget.path}');
        bool isPlaying =await _betterPlayerController.isPlaying();
        setState(() {
          if (_betterPlayerController != null) {

            if (isPlaying) {
              _betterPlayerController.pause();
            } else {
              _betterPlayerController.play();
            }
          }
        });
      },
      child:
      // _betterPlayerController.isPlaying()
      //     ? Container()
      //     :
    _isplayingg?Container()  :Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.black87, shape: BoxShape.circle),
        child: Center(
          child: Icon(
            Icons.play_arrow,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  String data;

  ImageWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Image.file(
            File(data),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

// class VideoThumb extends StatefulWidget {
//   String url;
//
//   VideoThumb(this.url);
//
//   @override
//   VideoThumbState createState() => VideoThumbState();
// }
//
// class _VideoThumbState extends State<VideoThumb> {
//   Widget projectWidget(String imageUrl) {
//     return FutureBuilder(
//       builder: (context, projectSnap) {
//         if (projectSnap.connectionState == ConnectionState.none &&
//             projectSnap.hasData == null) {
//           //print('project snapshot data is: ${projectSnap.data}');
//           return Container();
//         }
//         return projectSnap.data == null
//             ? Center(
//                 child: SizedBox(
//                   width: 50,
//                   height: 50,
//                   child: CircularProgressIndicator(
//                     value: null,
//                     strokeWidth: 7.0,
//                   ),
//                 ),
//               )
//             : Image.memory(
//                 projectSnap.data,
//                 fit: BoxFit.cover,
//               );
//       },
//       future: thumbnail(imageUrl),
//     );
//   }
//
//   thumbnail(String imageUrl) async {
//     var d = await VideoThumbnail.thumbnailData(
//       video: imageUrl,
//       imageFormat: ImageFormat.JPEG,
//       // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//       quality: 25,
//     );
//
//     return d;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return projectWidget(widget.url);
//   }
// }
//
// class ChewieDemo extends StatefulWidget {
//   final double ratio;
//   VideoPlayerController videoPlayerController1;
//
//   ChewieDemo({Key key, @required this.ratio = 1, this.videoPlayerController1})
//       : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _ChewieDemoState();
//   }
// }
//
// class _ChewieDemoState extends State<ChewieDemo> {
//   TargetPlatform _platform;
//
//   // VideoPlayerController _videoPlayerController1;
//   // VideoPlayerController _videoPlayerController2;
//   ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     print("gagan start");
//
//     widget.videoPlayerController1 = VideoPlayerController.network(
//         'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
//
//     _chewieController = ChewieController(
//       videoPlayerController: widget.videoPlayerController1,
//       aspectRatio: 3 / 2,
//       autoPlay: false,
//       looping: false,
//       autoInitialize: true,
//     );
//     _chewieController.addListener(() {
//       print("gagan");
//     });
//   }
//
//   // @override
//   void dispose() {
//     print("dispose");
//     _chewieController.pause();
//     widget.videoPlayerController1.pause();
//     // widget.videoPlayerController1.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: AspectRatio(
//           aspectRatio: widget.ratio,
//           child: Column(
//             children: <Widget>[
//               Expanded(
//                 child: Center(
//                   child: Chewie(
//                     controller: _chewieController,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }