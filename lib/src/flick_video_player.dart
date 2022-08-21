import 'package:flick_video_player/flick_video_player.dart';
import 'package:flick_video_player/src/utils/orientation_service.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class FlickVideoPlayer extends StatefulWidget {
  const FlickVideoPlayer({
    Key? key,
    required this.flickManager,
    this.flickVideoWithControls = const FlickVideoWithControls(controls: FlickPortraitControls()),
    this.flickVideoWithControlsFullscreen,
    this.wakelockEnabled = true,
    this.wakelockEnabledFullscreen = true,
  }) : super(key: key);

  final FlickManager flickManager;

  /// Widget to render video and controls.
  final Widget flickVideoWithControls;

  /// Widget to render video and controls in full-screen.
  final Widget? flickVideoWithControlsFullscreen;

  /// Prevents the screen from turning off automatically.
  ///
  /// Use [wakeLockEnabledFullscreen] to manage wakelock for full-screen.
  final bool wakelockEnabled;

  /// Prevents the screen from turning off automatically in full-screen.
  final bool wakelockEnabledFullscreen;

  @override
  _FlickVideoPlayerState createState() => _FlickVideoPlayerState();
}

class _FlickVideoPlayerState extends State<FlickVideoPlayer> with WidgetsBindingObserver {
  late FlickManager flickManager;
  bool _isFullscreen = false;
  // OverlayEntry? _overlayEntry

  @override
  void initState() {
    flickManager = widget.flickManager;
    flickManager.registerContext(context);

    if (widget.wakelockEnabled) {
      Wakelock.enable();
    }

    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    OrientationService.setOrientation(orientation: ScreenOrientation.portraitOnly);
    super.dispose();
  }

  // Listener on [FlickControlManager],
  // Pushes the full-screen if [FlickControlManager] is changed to full-screen.
  void listener() async {
    if (flickManager.flickControlManager!.isFullscreen && !_isFullscreen) {
      _switchToFullscreen();
    } else if (_isFullscreen && !flickManager.flickControlManager!.isFullscreen) {
      _exitFullscreen();
    }
  }

  _switchToFullscreen() {
    /// Disable previous wakelock setting.
    Wakelock.disable();

    if (widget.wakelockEnabledFullscreen) {
      Wakelock.enable();
    }

    _isFullscreen = true;
  }

  _exitFullscreen() {
    print('_exitFullscreen');

    /// Disable previous wakelock setting.
    Wakelock.disable();

    if (widget.wakelockEnabled) {
      Wakelock.enable();
    }

    _isFullscreen = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        flickManager.flickControlManager!.exitFullscreen();
        Navigator.pop(context);
        return Future.value(false);
      },
      child: FlickManagerBuilder(
        flickManager: flickManager,
        child: widget.flickVideoWithControls,
      ),
    );
  }
}
