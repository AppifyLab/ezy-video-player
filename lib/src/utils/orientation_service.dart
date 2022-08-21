import 'package:flutter/services.dart';

enum ScreenOrientation { portraitOnly, landscapeOnly, landscapeRight, landscapeLeft }

class OrientationService {
  static void setOrientation({ScreenOrientation? orientation}) {
    List<DeviceOrientation> orientations;
    switch (orientation) {
      case ScreenOrientation.portraitOnly:
        {
          orientations = [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ];
          break;
        }
      case ScreenOrientation.landscapeOnly:
        {
          orientations = [
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ];
          break;
        }

      case ScreenOrientation.landscapeRight:
        {
          orientations = [DeviceOrientation.landscapeRight];
          break;
        }
      case ScreenOrientation.landscapeLeft:
        {
          orientations = [DeviceOrientation.landscapeLeft];
          break;
        }
      default:
        {
          orientations = [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ];
          break;
        }
    }
    SystemChrome.setPreferredOrientations(orientations);
  }
}
