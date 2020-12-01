import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';

import 'player_widget.dart';

typedef void OnError(Exception exception);

const kUrl1 = 'http://192.168.0.107:8000/storage/audios/1.mp3';
const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
const kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

class AudioFileModel {
  String title;
  String name;

  AudioFileModel({this.title, this.name});


}

class AudioApp extends StatefulWidget {
  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;
  String fileName = 'audios';
  int fileIndex =0;
  double pinPillPosition = -1000;
  bool playing = false;

  Duration _duration = new Duration();
  Duration _position = new Duration();

  List<AudioFileModel> files = [
    new AudioFileModel(title: '1 Название аудио', name: 'audios/1.mp3'),
    new AudioFileModel(title: '2 Название аудио', name: 'audios/2.mp3'),
    new AudioFileModel(title: '3 Название аудио', name: 'audios/3.mp3'),
    new AudioFileModel(title: '4 Название аудио', name: 'audios/4.mp3'),
  ];

  List<String> fileNames = [
    'audios/1.mp3', 'audios/2.mp3', 'audios/3.mp3', 'audios/4.mp3'
  ];

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }

    audioCache.loadAll(fileNames);
    audioCache.fixedPlayer = advancedPlayer;

    initPlayer();
  }

  void initPlayer(){

    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  Widget slider() {
    return SliderTheme(
      data: SliderThemeData(
//          trackHeight: 2,
          trackShape: CustomTrackShape(),
//          activeTrackColor: Colors.red,
//          disabledActiveTrackColor: Colors.red,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15)),
      child: Slider(
          activeColor:  Colors.white,
          inactiveColor: Colors.white,
          value: _position.inSeconds.toDouble(),
          min: 0.0,
          max: _duration.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              seekToSecond(value.toInt());
              value = value;
            });}),
    );
  }

  Widget remoteUrl() {
    return SingleChildScrollView(
      child: _Tab(children: [
        Text(
          'Sample 1 ($kUrl1)',
          key: Key('url1'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        PlayerWidget(url: kUrl1),
        Text(
          'Sample 2 ($kUrl2)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        PlayerWidget(url: kUrl2),
        Text(
          'Sample 3 ($kUrl3)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        PlayerWidget(url: kUrl3),
        Text(
          'Sample 4 (Low Latency mode) ($kUrl1)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        PlayerWidget(url: kUrl1, mode: PlayerMode.LOW_LATENCY),
      ]),
    );
  }

  Widget localAsset() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
          height: MediaQuery.of(context).size.height * 0.60,
          child: ListView.separated
            (
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: files.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ListTile(
                  title: Text(
                    files[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(fileName == files[index].name ? FontAwesomeIcons.pause : FontAwesomeIcons.play, color: Theme.of(context).buttonColor,),
                  onTap: () {
                    setState(() {
                      fileIndex = index;
                      audioCache.clearCache();
                      advancedPlayer.stop();
                      fileName = files[index].name;
                      audioCache.play(fileName);
//                  advancedPlayer.resume();
//                  getDuration();
                      pinPillPosition = MediaQuery.of(context).size.height * 0.06;
                      playing = true;
                    });
                  },
                );
              }
          ),
        ),
          AnimatedPositioned(
              bottom: pinPillPosition, right: 0, left: 0,
              duration: Duration(milliseconds: 200),
              child: Container(
//                    margin: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor,
//                        borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Column(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Column(
                              children: [
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(_position.inMinutes.toString().padLeft(2, '0') + ':' + _position.inSeconds.toString().padLeft(2, '0'), style: TextStyle(color: Colors.white),),
                                    slider(),
//                                  getLocalFileDuration(),
                                    Text((_duration.inMinutes + (_duration.inSeconds.toInt()/60).toInt()).toString().padLeft(2, '0') + ':' + ((_duration.inSeconds.round()%60) ).toString().padLeft(2, '0'), style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                  children: [
                                    _Btn1(
                                      txt: Icon(FontAwesomeIcons.stepBackward, size: 30,  color: Colors.white,),
                                      onPressed: () {
                                        setState(() {
                                          if(fileIndex == 0) {
                                            fileName =
                                                fileName.replaceRange(7,8,
                                                    (files.length)
                                                        .toString());
                                            fileIndex = files.length - 1;
                                          }
                                          else {
                                            fileName =
                                                fileName.replaceRange(7,8,
                                                    (fileIndex).toString());
                                            fileIndex = fileIndex -1;
                                          }
                                          audioCache.play(fileName);
                                          playing = true;

                                        });
                                      },
                                    ),
                                    _Btn1(
                                      txt: Icon(playing ? FontAwesomeIcons.pauseCircle : FontAwesomeIcons.playCircle, size: 70, color: Colors.white),
                                      onPressed: () {
                                        if(advancedPlayer.state == AudioPlayerState.PLAYING){
                                          advancedPlayer.pause();
                                        }
                                        else if(advancedPlayer.state == AudioPlayerState.PAUSED){
                                          audioCache.play(fileName);
                                        }
                                        else if(advancedPlayer.state == AudioPlayerState.STOPPED){
                                          audioCache.play(fileName);
                                        }
                                        else {
                                          advancedPlayer.pause();
                                        }
                                        setState(() {
                                          playing = ! playing;
                                        });
                                      },
                                    ),
                                    _Btn1(
                                      txt: Icon(FontAwesomeIcons.stepForward, size: 30, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          if(fileIndex < files.length-1) {
                                            fileName =
                                                fileName.replaceRange(7,8,
                                                    (fileIndex + 2)
                                                        .toString());
                                            fileIndex = fileIndex + 1;
                                          }
                                          else if(fileIndex >= files.length-1) {
                                            fileName =
                                                fileName.replaceRange(7,8,
                                                    (1).toString());
                                            fileIndex = 0;
                                          }
                                          audioCache.play(fileName);
                                          playing = true;

                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )), // first widget
                      ])
              )  // end of Align
          ),
      ]

      ),
    );
  }

  Future<int> _getDuration() async {
    File audiofile = await audioCache.load(fileName);
    await advancedPlayer.setUrl(
      audiofile.path,
    );
    int duration = await Future.delayed(
      Duration(seconds: 2),
          () => advancedPlayer.getDuration(),
    );
    return duration;
  }

  getLocalFileDuration() {
    return FutureBuilder<int>(
      future: _getDuration(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('No Connection...');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Text(
              'audios/audio.mp3 duration is: ${Duration(milliseconds: snapshot.data)}',
            );
        }
        return null; // unreachable
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioCache.clearCache();
    advancedPlayer.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Duration>.value(
            initialData: Duration(),
            value: advancedPlayer.onAudioPositionChanged),
      ],
      child: localAsset(),
    );
  }
}


class _Tab extends StatelessWidget {
  final List<Widget> children;

  const _Tab({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;

  const _Btn({Key key, this.txt, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 48.0,
      child: RaisedButton(child: Text(txt), onPressed: onPressed),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = 2;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2.2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, 2);
  }
}
class _Btn1 extends StatelessWidget {
  final Widget txt;
  final VoidCallback onPressed;

  const _Btn1({Key key, this.txt, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 30.0,
      child: InkWell(child: txt, onTap: onPressed),
    );
  }
}