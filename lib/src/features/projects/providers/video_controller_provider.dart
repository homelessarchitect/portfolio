import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

// ------------------------------------------------------------------ //
//  Video Controller Provider                                           //
//  FutureProvider.family keyed by asset path.                         //
//                                                                     //
//  Strategy:                                                           //
//   • Initialises the controller in the background (parallel to build) //
//   • keepAlive → survives pop/push; revisit is instant               //
//   • Call ref.read(videoControllerProvider(url).future) before       //
//     navigation to pre-warm the controller                           //
// ------------------------------------------------------------------ //

final videoControllerProvider =
    FutureProvider.family<VideoPlayerController, String>((
      ref,
      assetPath,
    ) async {
      // keepAlive prevents Riverpod from disposing the controller when the
      // widget tree that watches it unmounts (e.g. user navigates away).
      ref.keepAlive();

      final controller = VideoPlayerController.asset(assetPath);

      // Dispose on explicit provider invalidation or app shutdown.
      ref.onDispose(controller.dispose);

      await controller.initialize();
      controller.setLooping(true);
      controller.setVolume(0);
      // Seek to frame 0 so the first frame is already painted before play().
      await controller.seekTo(Duration.zero);
      controller.play();

      return controller;
    });
