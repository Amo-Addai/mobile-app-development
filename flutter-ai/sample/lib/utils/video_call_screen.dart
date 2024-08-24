import 'package:flutter/material.dart';
import 'package:twilio_programmable_video/twilio_programmable_video.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallScreen extends StatefulWidget {
  final String token;

  VideoCallScreen(this.token);

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late Room _room;
  VideoTrack? _localVideoTrack;
  VideoTrack? _remoteVideoTrack;

  @override
  void initState() {
    super.initState();
    _connectToRoom();
  }

  void _connectToRoom() async {
    final connectOptions = ConnectOptions(
      widget.token,
      roomName: 'MyRoom',
      videoTracks: [_localVideoTrack as LocalVideoTrack],
    );
    _room = await TwilioProgrammableVideo.connect(connectOptions);
    _room?.onParticipantConnected.listen(_onParticipantConnected);
  }

  // void _onParticipantConnected(Participant participant) {
  //   participant.onVideoTrackAdded.listen((track) {
  //     setState(() {
  //       _remoteVideoTrack = track;
  //     });
  //   });
  // }

  void _onParticipantConnected(RoomParticipantConnectedEvent event) {
    final participant = event.remoteParticipant;
    participant.onVideoTrackSubscribed.listen((publication) {
      setState(() {
        _remoteVideoTrack = publication.remoteVideoTrack;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Stack(
        children: [
          _remoteVideoTrack != null
              ? VideoTrackWidget(_remoteVideoTrack!)
              : Center(child: Text('Waiting for participant...')),
          Align(
            alignment: Alignment.topLeft,
            child: _localVideoTrack != null
                ? VideoTrackWidget(_localVideoTrack!)
                : Container(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _room.disconnect();
    (_localVideoTrack as LocalVideoTrack)?.release(); // .dispose();
    super.dispose();
  }
}

class VideoTrackWidget extends StatefulWidget { // StatelessWidget {
  final VideoTrack videoTrack;

  VideoTrackWidget(this.videoTrack);

  /* // todo: not required for StatefulWidget
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      // child: videoTrack.widget(),
      // child: RemoteVideoView(
      //   videoTrack as RemoteVideoTrack,
      // ),
      child: _buildVideoWidget(),
    );
  }
  */

  /*
  Widget _buildVideoWidget() {
    if (videoTrack is LocalVideoTrack) {
      return LocalVideoView(videoTrack as LocalVideoTrack, mirror: true);
    } else if (videoTrack is RemoteVideoTrack) {
      return RemoteVideoView(videoTrack as RemoteVideoTrack);
    } else {
      return Text('Unsupported video track type');
    }
  }
  */

  /* // todo: not required for StatefulWidget
  Widget _buildVideoWidget() {
    if (videoTrack is LocalVideoTrack) {
      return LocalVideoTrackWidget(videoTrack as LocalVideoTrack);
    } else if (videoTrack is RemoteVideoTrack) {
      return RemoteVideoTrackWidget(videoTrack as RemoteVideoTrack);
    } else {
      return Text('Unsupported video track type');
    }
  }
  */

  @override
  _VideoTrackWidgetState createState() => _VideoTrackWidgetState();

}

class _VideoTrackWidgetState extends State<VideoTrackWidget> {
  RTCVideoRenderer _renderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initializeRenderer();
  }

  void _initializeRenderer() async {
    await _renderer.initialize();
    if (widget.videoTrack is LocalVideoTrack) {
      // (widget.videoTrack as LocalVideoTrack).addRenderer(_renderer);
      final track = widget.videoTrack as LocalVideoTrack;
      _renderer.srcObject = track.mediaStream;
    } else if (widget.videoTrack is RemoteVideoTrack) {
      // (widget.videoTrack as RemoteVideoTrack).addRenderer(_renderer);
      final track = widget.videoTrack as RemoteVideoTrack;
      track.onVideoTrackSubscribed = (videoTrack) {
        _renderer.srcObject = videoTrack.mediaStream;
        setState(() {});
      };
    }
    setState(() {});
  }

  @override
  void dispose() {
    _renderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RTCVideoView(_renderer),
    );
  }
}

class LocalVideoTrackWidget extends StatefulWidget { // StatelessWidget {
  final LocalVideoTrack localVideoTrack;

  LocalVideoTrackWidget(this.localVideoTrack);


  /* // todo: not required for StatefulWidget
  @override
  Widget build(BuildContext context) {
    // return VideoView(localVideoTrack);
    return RTCVideoView(localVideoTrack);
  }
  */

  @override
  _LocalVideoTrackWidgetState createState() => _LocalVideoTrackWidgetState();
}

class _LocalVideoTrackWidgetState extends State<LocalVideoTrackWidget> {
  RTCVideoRenderer _renderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initializeRenderer();
  }

  void _initializeRenderer() async {
    await _renderer.initialize();
    widget.localVideoTrack.addRenderer(_renderer);
    // final track = widget.localVideoTrack as LocalVideoTrack;
    // _renderer.srcObject = track.mediaStream;
    setState(() {});
  }

  @override
  void dispose() {
    _renderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RTCVideoView(_renderer),
    );
  }
}

class RemoteVideoTrackWidget extends StatefulWidget { // StatelessWidget {
  final RemoteVideoTrack remoteVideoTrack;

  RemoteVideoTrackWidget(this.remoteVideoTrack);

  /* // todo: not required for StatefulWidget
  @override
  Widget build(BuildContext context) {
    // return VideoView(remoteVideoTrack);
    return RTCVideoView(remoteVideoTrack);
  }
  */

  @override
  _RemoteVideoTrackWidgetState createState() => _RemoteVideoTrackWidgetState();
}

class _RemoteVideoTrackWidgetState extends State<RemoteVideoTrackWidget> {
  RTCVideoRenderer _renderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initializeRenderer();
  }

  void _initializeRenderer() async {
    await _renderer.initialize();
    // widget.remoteVideoTrack.addRenderer(_renderer);
    final track = widget.remoteVideoTrack as RemoteVideoTrack;
    track.onVideoTrackSubscribed = (videoTrack) {
      _renderer.srcObject = videoTrack.mediaStream;
      setState(() {});
    };
    setState(() {});
  }

  @override
  void dispose() {
    _renderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RTCVideoView(_renderer),
    );
  }
}
