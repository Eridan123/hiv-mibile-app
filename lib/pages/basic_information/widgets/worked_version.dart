//
//
//
//import 'dart:async';
//import 'dart:io';
//
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:http/http.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:provider/provider.dart';
//import 'package:flutter/src/foundation/constants.dart';
//
//typedef void OnError(Exception exception);
//
//class AudioWidget extends StatefulWidget {
//
//
//  @override
//  _AudioWidgetState createState() => _AudioWidgetState();
//
//}
//
//class _AudioWidgetState extends State<AudioWidget> {
//
//  AudioCache audioCache = AudioCache();
//  AudioPlayer advancedPlayer = AudioPlayer();
//  String localFilePath;
//  String fileName = 'audios/1.mp3';
//  Duration full ;
//  Duration current ;
//  double pinPillPosition =50;
//
//  @override
//  void initState() {
//    super.initState();
//
//    if (kIsWeb) {
//      // Calls to Platform.isIOS fails on web
//      return;
//    }
//    if (Platform.isIOS) {
//      if (audioCache.fixedPlayer != null) {
//        audioCache.fixedPlayer.startHeadlessService();
//      }
//      advancedPlayer.startHeadlessService();
//    }
//  }
//
//  getDuration(){
//    advancedPlayer.onDurationChanged.listen((Duration d) {
//      setState(() => full = d);
//    });
//  }
//
//  Widget localAsset() {
//    return Container(
//      height: MediaQuery.of(context).size.height * 0.7,
//      child: Stack(
//        children: [
//          ListView(
//            children: [
//              ListTile(
//                title: Container(
//                    child: Text('1 Название аудио', style: TextStyle(fontSize: 24),)
//                ),
//                onTap: () {
//                  setState(() {
//                    fileName = 'audios/1.mp3';
//                    advancedPlayer.resume();
//                    getDuration();
//                  });
//                },
//              ),
//              ListTile(
//                title: Container(
//                    child: Text('2 Название аудио', style: TextStyle(fontSize: 24),)
//                ),
//                onTap: () {
//                  setState(() {
//                    fileName = 'audios/2.mp3';
//                    advancedPlayer.resume();
//                    getDuration();
//                  });
//                },
//              ),
//              ListTile(
//                title: Container(
//                    child: Text('3 Название аудио', style: TextStyle(fontSize: 24),)
//                ),
//                onTap: () {
//                  setState(() {
//                    fileName = 'audios/3.mp3';
//                    advancedPlayer.resume();
//                    getDuration();
//                  });
//                },
//              ),
//              ListTile(
//                title: Container(
//                    child: Text('4 Название аудио', style: TextStyle(fontSize: 24),)
//                ),
//                onTap: () {
//                  setState(() {
//                    fileName = 'audios/4.mp3';
//                    advancedPlayer.resume();
//                    getDuration();
//                  });
//                },
//              ),
//            ],
//          ),
//          AnimatedPositioned(
//              bottom: pinPillPosition, right: 0, left: 0,
//              duration: Duration(milliseconds: 200),
//              child: Center(
//                child: Align(
//                    alignment: Alignment.center,
//                    child: Container(
//                        margin: EdgeInsets.all(5),
//                        height: MediaQuery.of(context).size.height * 0.20,
//                        decoration: BoxDecoration(
//                            color: Theme.of(context).textSelectionHandleColor,
//                            borderRadius: BorderRadius.all(Radius.circular(50)),
//                            boxShadow: <BoxShadow>[
//                              BoxShadow(
//                                  blurRadius: 20,
//                                  offset: Offset.zero,
//                                  color: Colors.grey.withOpacity(0.5)
//                              )]
//                        ),
//                        child: Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Container(
//                                  padding: EdgeInsets.all(5.0),
//                                  child: Column(
//                                    children: [
//                                      getLocalFileDuration(),
//                                      full != null ?Text(full.inHours.toString() + ' : '+ full.inMinutes.toString() + ' : ' + full.inSeconds.toString()) : Text(''),
//                                      SafeArea(
//                                        bottom: true,
//                                        child: Row(
//                                          children: [
//                                            _Btn1(
//                                              txt: Icon(FontAwesomeIcons.playCircle),
//                                              onPressed: () => advancedPlayer.resume(),
//                                            ),
//                                            _Btn1(
//                                              txt: Icon(FontAwesomeIcons.pauseCircle),
//                                              onPressed: () => advancedPlayer.pause(),
//                                            ),
//                                            _Btn1(
//                                              txt: Icon(FontAwesomeIcons.stopCircle),
//                                              onPressed: () => advancedPlayer.stop(),
//                                            ),
//                                          ],
//                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                        ),
//                                      ),
//                                    ],
//                                  )), // first widget
//                            ])
//                    )  // end of Container
//                ),
//              )  // end of Align
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future<int> _getDuration() async {
//    File audiofile = await audioCache.load(fileName);
//    await advancedPlayer.setUrl(
//      audiofile.path,
//    );
//    int duration = await advancedPlayer.getCurrentPosition();
//    return duration;
//  }
//
//  getLocalFileDuration() {
//    return FutureBuilder<int>(
//      future: _getDuration(),
//      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//            return Text('Соединение отсутствует...');
//          case ConnectionState.active:
//          case ConnectionState.waiting:
//            return Text('...');
//          case ConnectionState.done:
//            if (snapshot.hasError) return Text('Ошибка:');
//            return Text(
//              '${Duration(milliseconds: snapshot.data)}',
//            );
//        }
//        return null; // unreachable
//      },
//    );
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    advancedPlayer.stop();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MultiProvider(
//      providers: [
//        StreamProvider<Duration>.value(
//            initialData: Duration(),
//            value: advancedPlayer.onAudioPositionChanged),
//      ],
//      child: Container(child: localAsset()),
//    );
//  }
//}
//
//class Advanced extends StatefulWidget {
//  final AudioPlayer advancedPlayer;
//
//  const Advanced({Key key, this.advancedPlayer}) : super(key: key);
//
//  @override
//  _AdvancedState createState() => _AdvancedState();
//}
//
//class _AdvancedState extends State<Advanced> {
//  bool seekDone;
//
//  @override
//  void initState() {
//    widget.advancedPlayer.seekCompleteHandler =
//        (finished) => setState(() => seekDone = finished);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final audioPosition = Provider.of<Duration>(context);
//    return SingleChildScrollView(
//      child: _Tab(
//        children: [
//          /* Column(
//            children: [
//              Text('Release Mode'),
//              Row(children: [
//                _Btn(
//                  txt: 'STOP',
//                  onPressed: () =>
//                      widget.advancedPlayer.setReleaseMode(ReleaseMode.STOP),
//                ),
//                _Btn(
//                  txt: 'LOOP',
//                  onPressed: () =>
//                      widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP),
//                ),
//                _Btn(
//                  txt: 'RELEASE',
//                  onPressed: () =>
//                      widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE),
//                ),
//              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
//            ],
//          ),*/
//          Column(
//            children: [
//              Text('Volume'),
//              Row(
//                children: [0.0, 0.5, 1.0, 2.0].map((e) {
//                  return _Btn(
//                    txt: e.toString(),
//                    onPressed: () => widget.advancedPlayer.setVolume(e),
//                  );
//                }).toList(),
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              ),
//            ],
//          ),
//          Column(
//            children: [
//              Text('Control'),
//              Row(
//                children: [
//                  _Btn(
//                    txt: 'resume',
//                    onPressed: () => widget.advancedPlayer.resume(),
//                  ),
//                  _Btn(
//                    txt: 'pause',
//                    onPressed: () => widget.advancedPlayer.pause(),
//                  ),
//                  _Btn(
//                    txt: 'stop',
//                    onPressed: () => widget.advancedPlayer.stop(),
//                  ),
//                  _Btn(
//                    txt: 'release',
//                    onPressed: () => widget.advancedPlayer.release(),
//                  ),
//                ],
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              ),
//            ],
//          ),
//          Column(
//            children: [
//              Text('Seek in milliseconds'),
//              Row(
//                children: [
//                  _Btn(
//                      txt: '100ms',
//                      onPressed: () {
//                        widget.advancedPlayer.seek(
//                          Duration(
//                            milliseconds: audioPosition.inMilliseconds + 100,
//                          ),
//                        );
//                        setState(() => seekDone = false);
//                      }),
//                  _Btn(
//                      txt: '500ms',
//                      onPressed: () {
//                        widget.advancedPlayer.seek(
//                          Duration(
//                            milliseconds: audioPosition.inMilliseconds + 500,
//                          ),
//                        );
//                        setState(() => seekDone = false);
//                      }),
//                  _Btn(
//                      txt: '1s',
//                      onPressed: () {
//                        widget.advancedPlayer.seek(
//                          Duration(seconds: audioPosition.inSeconds + 1),
//                        );
//                        setState(() => seekDone = false);
//                      }),
//                  _Btn(
//                      txt: '1.5s',
//                      onPressed: () {
//                        widget.advancedPlayer.seek(
//                          Duration(
//                            milliseconds: audioPosition.inMilliseconds + 1500,
//                          ),
//                        );
//                        setState(() => seekDone = false);
//                      }),
//                ],
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              ),
//            ],
//          ),
//          Column(
//            children: [
//              Text('Rate'),
//              Row(
//                children: [0.5, 1.0, 1.5, 2.0].map((e) {
//                  return _Btn(
//                    txt: e.toString(),
//                    onPressed: () {
//                      widget.advancedPlayer.setPlaybackRate(playbackRate: e);
//                    },
//                  );
//                }).toList(),
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              ),
//            ],
//          ),
//          Text('Audio Position: ${audioPosition}'),
//          if (seekDone != null) Text(seekDone ? 'Seek Done' : 'Seeking...'),
//        ],
//      ),
//    );
//  }
//}
//
//class _Tab extends StatelessWidget {
//  final List<Widget> children;
//
//  const _Tab({Key key, this.children}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Container(
//        alignment: Alignment.topCenter,
//        padding: EdgeInsets.all(16.0),
//        child: SingleChildScrollView(
//          child: Column(
//            children: children
//                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
//                .toList(),
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class _Btn extends StatelessWidget {
//  final String txt;
//  final VoidCallback onPressed;
//
//  const _Btn({Key key, this.txt, this.onPressed}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ButtonTheme(
//      minWidth: 48.0,
//      child: RaisedButton(child: Text(txt), onPressed: onPressed),
//    );
//  }
//}
//class _Btn1 extends StatelessWidget {
//  final Widget txt;
//  final VoidCallback onPressed;
//
//  const _Btn1({Key key, this.txt, this.onPressed}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ButtonTheme(
//      minWidth: 48.0,
//      child: RaisedButton(child: txt, onPressed: onPressed),
//    );
//  }
//}