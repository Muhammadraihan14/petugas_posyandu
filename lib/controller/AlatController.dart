// import 'package:flutter/material.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class RealTimeData extends ChangeNotifier {
//   String _title = 'Initial Title';

//   String get title => _title;

//   void updateTitle(String newTitle) {
//     _title = newTitle;
//     notifyListeners();
//   }
// }

// class PusherStreamHandler {
//   // PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

//   PusherChannelsFlutter _pusherChannels;
//   RealTimeData _realTimeData;

//   PusherStreamHandler(this._realTimeData) {
//     _pusherChannels = PusherChannels();

//     // Ganti dengan informasi kredensial Pusher Anda
//     _pusherChannels.init(
//       "YOUR_APP_KEY",
//       PusherOptions(
//         cluster: "YOUR_CLUSTER",
//         encrypted: true,
//       ),
//     );

//     _subscribeToChannel();
//   }

//   void _subscribeToChannel() {
//     _pusherChannels.bind('update_event', (PusherEvent event) {
//       // Update state ketika menerima event dari Pusher Streams
//       _realTimeData.updateTitle(event.data['title']);
//     });
//   }

//   void dispose() {
//     _pusherChannels.disconnect();
//   }
// }