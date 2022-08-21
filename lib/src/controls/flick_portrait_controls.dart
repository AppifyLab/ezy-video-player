import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';

/// Default portrait controls.
// ignore: must_be_immutable
class FlickPortraitControls extends StatefulWidget {
  const FlickPortraitControls({Key? key, this.iconSize = 20, this.fontSize = 12, this.flickManager, this.progressBarSettings}) : super(key: key);

  /// Icon size.
  ///
  /// This size is used for all the player icons.
  final double iconSize;

  /// Font size.
  ///
  /// This size is used for all the text.
  final double fontSize;

  /// [FlickManager] flickManager.
  final FlickManager? flickManager;

  /// [FlickProgressBarSettings] settings.
  final FlickProgressBarSettings? progressBarSettings;

  @override
  State<FlickPortraitControls> createState() => _FlickPortraitControlsState();
}

class _FlickPortraitControlsState extends State<FlickPortraitControls> {
  bool showLeftDuration = false, isFullscreen = false;

  @override
  void initState() {
    super.initState();
    isFullscreen = widget.flickManager?.flickControlManager?.isFullscreen ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: FlickVideoBuffer(
                  child: FlickAutoHideChild(
                    showIfVideoNotInitialized: false,
                    child: FlickPlayToggle(
                      size: 30,
                      color: Colors.black,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlickVideoProgressBar(
                    flickProgressBarSettings: widget.progressBarSettings,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlickPlayToggle(
                        size: widget.iconSize,
                      ),
                      SizedBox(
                        width: widget.iconSize / 2,
                      ),
                      FlickSoundToggle(
                        size: widget.iconSize,
                      ),
                      SizedBox(
                        width: widget.iconSize / 2,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          onTap: () {
                            setState(() {
                              showLeftDuration = !showLeftDuration;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: isFullscreen ? 30 : 15),
                            child: Row(
                              children: [
                                if (showLeftDuration)
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 11,
                                      letterSpacing: 0.4,
                                      color: Colors.white,
                                    ),
                                  ),
                                showLeftDuration
                                    ? FlickLeftDuration(fontSize: widget.fontSize, color: Colors.white)
                                    : FlickCurrentPosition(fontSize: widget.fontSize, color: Colors.white),
                                SizedBox(width: widget.iconSize / 4),
                                Text(
                                  '/',
                                  style: TextStyle(
                                    fontSize: 11,
                                    letterSpacing: 0.4,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: widget.iconSize / 4),
                                FlickTotalDuration(fontSize: widget.fontSize, color: Colors.white),
                                // SizedBox(width: widget.iconSize / 2),
                                // FlickSoundToggle(size: widget.iconSize),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FlickSubtitleToggle(
                        size: widget.iconSize,
                      ),
                      SizedBox(
                        width: widget.iconSize / 2,
                      ),
                      FlickFullScreenToggle(
                        size: widget.iconSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
