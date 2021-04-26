import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/video_player/video_player_bloc.dart';
import 'package:flutter_app/blocs/video_player/video_player_event.dart';
import 'package:flutter_app/blocs/video_player/video_player_state.dart';
import 'package:flutter_app/services/video_controller_service.dart';
import 'package:flutter_app/video.dart';
import 'package:flutter_app/widgets/custom_video_player.dart';
import 'package:flutter_app/widgets/custom_video_player12.dart';
import 'package:flutter_app/widgets/video_player_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPage extends StatelessWidget {
  final Video video;

  const VideoPage({Key key, @required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildVideoPlayer(),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return BlocProvider<VideoPlayerBloc>(
      create: (context) => VideoPlayerBloc(
          RepositoryProvider.of<VideoControllerService>(context))
        ..add(VideoSelectedEvent(video)),
      child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[_getPlayer(context, state)],
          );
        },
      ),
    );
  }

  Widget _getPlayer(BuildContext context, VideoPlayerState state) {
    if (state is VideoPlayerStateLoaded) {
      // return VideoPlayerWidget(
      //   key: Key(state.video.url),
      //   videoTitle: state.video.title,
      //   controller: state.controller,
      //   thumbImage: state.video.thumbImage,
      // );
      // return InkWell(
      //   child: CustomPlayer(
      //     thumbImage: state.video.thumbImage,
      //     videoTitle: state.video.title,
      //     url: state.video.url,
      //   ),
      //   onTap: (){
      //     print(state.video.url);
      //   },
      // );

      return AllMediaWidget(path: state.video.url,thumbnailForVideo:state.video.thumbImage,);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenWidth / ASPECT_RATIO;

    if (state is VideoPlayerStateError) {
      return Container(
        height: containerHeight,
        color: Colors.grey,
        child: Center(
          child: Text(state.message),
        ),
      );
    }

    return Container(
      height: containerHeight,
      color: Colors.grey,
      child: Center(
        child: Text('Initialising video...'),
      ),
    );
  }
}
