import 'dart:async';
import 'dart:io';

import 'package:HIVApp/utils/constants.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';

typedef void OnError(Exception exception);

class AudioFileModel {
  String title;
  String name;

  AudioFileModel({this.title, this.name});


}

class AudioWidget extends StatefulWidget {


  @override
  _AudioWidgetState createState() => _AudioWidgetState();

}

class _AudioWidgetState extends State<AudioWidget> {

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;
  String fileName = 'audios';
  Duration full ;
  Duration current ;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  double pinPillPosition = -1000;
  bool playing = false;
  int fileIndex =0;

  List<AudioFileModel> files = [
    new AudioFileModel(title: '1 Название аудио', name: 'audios/1.mp3'),
    new AudioFileModel(title: '2 Название аудио', name: 'audios/2.mp3'),
    new AudioFileModel(title: '3 Название аудио', name: 'audios/3.mp3'),
    new AudioFileModel(title: '4 Название аудио', name: 'audios/4.mp3'),
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
    advancedPlayer.mode = PlayerMode.MEDIA_PLAYER;
//    advancedPlayer.setReleaseMode(ReleaseMode.STOP);
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


  getDuration() async{
    advancedPlayer.onPlayerCompletion.listen((event) {
      print(fileName);
      setState(() {
        advancedPlayer.resume();
      });
    });
  }

  Widget localAsset() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
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
                        fileName = files[index].name;
//                        audioCache.play(fileName);
                        advancedPlayer.resume();
                        getDuration();
                        pinPillPosition = MediaQuery.of(context).size.height * 0.03;
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
                  height: MediaQuery.of(context).size.height * 0.18,
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
//                                    crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(_position.inMinutes.toString().padLeft(2, '0') + ':' + _position.inSeconds.toString().padLeft(2, '0'), style: TextStyle(color: Colors.white),),
                                    slider(),
                                    getLocalFileDuration(),
                                    Text((_duration.inMinutes + (_duration.inSeconds/60)).toString().padLeft(2, '0') + ':' + (_duration.inSeconds%60).toString().padLeft(2, '0'), style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ],
                            )), // first widget
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                SafeArea(
                                  bottom: true,
                                  child: Row(
                                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                    children: [
                                      _Btn1(
                                        txt: Icon(FontAwesomeIcons.stepBackward, size: 35,  color: Colors.white,),
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
                                            advancedPlayer.resume();
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
                                            advancedPlayer.resume();
                                          }
                                          else if(advancedPlayer.state == AudioPlayerState.STOPPED){
                                            advancedPlayer.resume();
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
                                        txt: Icon(FontAwesomeIcons.stepForward, size: 35, color: Colors.white),
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
                                            advancedPlayer.resume();
                                            playing = true;

                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )), // first widget
                      ])
              )  // end of Align
          ),
        ],
      ),
    );
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  Widget slider() {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
          trackShape: CustomTrackShape(),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15)),
      child: Slider(
        activeColor:  Colors.white,

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
            return Text('');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('');
            return Text(
              '',
            );
        }
        return null; // unreachable
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.stop();
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
      child: Container(
          width: MediaQuery.of(context).size.width * 1,
          child: localAsset()),
    );
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

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx - (parentBox.size.width/8);
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width + (parentBox.size.width/2.2);
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}