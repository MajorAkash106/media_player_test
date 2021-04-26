import 'package:equatable/equatable.dart';
import 'package:flutter_app/video.dart';


abstract class VideoPlayerEvent extends Equatable{
  @override
  List<Object> get props => const [];
}

class VideoSelectedEvent extends VideoPlayerEvent{
  final Video video;

  VideoSelectedEvent(this.video) : assert(video != null);

  @override
  List<Object> get props => [video];
}