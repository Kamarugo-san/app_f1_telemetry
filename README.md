# F1 telemetry
The app uses the F1 2020 game's native solution to sending telemetry data via
UDP packets to display real time information to the user.
The app listens for UDP packets on the game's native port `20777` and decodes
them into objects the widgets can use. For the decoding it is used the official
[reference](https://forums.codemasters.com/topic/54423-f1%C2%AE-2020-udp-specification/)
made by Codemasters.

## Setting up the game
*  Go to Game Options -> Settings -> Telemetry Settings.
*  Turn `UDP Telemetry` ON
*  Turn `UDP Broadcast Mode` OFF
*  Set the `UDP IP Address` to the IP address of the device running the app
*  Set the `UDP Port` to `20777`
*  Set the `UDP Send Rate` to `30Hz` or `20Hz`
*  Set the `UDP Format` to `2020`

## Installing
This app is developed in Flutter. In order to run, it is necessary to have the
Flutter SDK installed and running. See https://flutter.dev/docs/get-started/install
to get started with Flutter.

Once your machine is set up, clone this project and run:
```
flutter run
```

### Performance
The decoding process takes time, meaning the higher the game UDP frequency is,
the faster the CPU has to be. Lowering the frequency avoids stuttering. 20Hz
and 30Hz seem to be the most stable frequencies.

### UI
The user is the one to define which and where the widgets are. This way, we
provide highly customizable racing dashboards, with the info the user wants
to see.

## Team
[DouglasSnt](https://github.com/DouglasSnt)
[Kamarugo-san](https://github.com/Kamarugo-san)
