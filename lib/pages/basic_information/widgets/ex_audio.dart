import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:HIVApp/data/configs.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:http/http.dart' as http;

import '../../../db/db_provider.dart';
import '../../../db/audio_db.dart';

import 'player_widget.dart';

typedef void OnError(Exception exception);

const kUrl1 = 'http://vich.ulut.kg/storage/audios/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5/202012021512481.mp3';
class AudioCategoryModel {
  String category_name;
  List<AudioFileModel> audios;

  AudioCategoryModel({this.category_name, this.audios});
}
class AudioFileModel {
  String title;
  String name;
  bool downloaded = false;

  AudioFileModel({this.title, this.name, this.downloaded});

  static Future<List<AudioCategoryModel>> getList() async {
    final url =
        Configs.ip+'api/audioinformations';
    try {
      Map<String, String> headers = {"Content-type": "application/json","lang": Prefs.getString(Prefs.LANGUAGE)};
      final response = await http.get(
        url,
        headers:headers,
      );
      List<AudioCategoryModel> mmList = new List<AudioCategoryModel>();
      for(var i in json.decode(response.body)){
        AudioCategoryModel newModel = new AudioCategoryModel(category_name: i['category_name'], audios: responseToObjects(i['audios']) );
        mmList.add(newModel);
      }
      return mmList;
    }
    catch (error) {
      throw error;
    }
  }

  static List<AudioFileModel> responseToObjects(var responseBody){
    List<AudioFileModel> list = new List<AudioFileModel>();
    for(var j in responseBody){
      AudioFileModel model = new AudioFileModel();
      model.name = j['path'];
      model.title = j['name'];
      model.downloaded = false;

      list.add(model);
    }
    return list;
  }
}

class AudioApp extends StatefulWidget {

  List<AudioFileModel> list;
  List<AudioDb> dbList;
  String category_name;

  AudioApp({this.list, this.dbList, this.category_name});

  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String fileName = 'audios';
  int fileIndex =0;
  double pinPillPosition = -1000;
  double playerHeight = 0;
  bool playing = false;
  String category_name;

  Duration _duration = new Duration();
  Duration _position = new Duration();

  List<AudioFileModel> files = new List<AudioFileModel>();
  List<AudioDb> dbList = new List<AudioDb>();

  List<AudioFileModel> compareRemoteLocalAudios(List<AudioFileModel> someList, List<AudioDb> anotherList){
    List<AudioFileModel> newList =new List<AudioFileModel>();
    for(var i in someList){
      AudioFileModel newModel = new AudioFileModel();
      newModel.title = i.title;
      newModel.name = i.name;
      if(i.downloaded == null)
        newModel.downloaded = false;
      else
        newModel.downloaded = i.downloaded;
      for(var j in anotherList){
        if(i.name == j.remote_path){
          newModel.downloaded = true;
          newModel.name = j.local_path;
          break;
        }
      }
      newList.add(newModel);
    }
    return newList;
  }


  @override
  void initState() {
    super.initState();
    category_name = widget.category_name;
    files = compareRemoteLocalAudios(widget.list, widget.dbList);
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

  Future _loadFile(AudioFileModel model) async {
    final bytes = await readBytes(Configs.file_ip+model.name);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${model.title}.mp3');

    await file.writeAsBytes(bytes).then((value) async {
      AudioDb audioDb = new AudioDb(title: model.title, local_path: file.path, remote_path: model.name, category_name: category_name);
      await DBProvider.db.newAudioFile(audioDb).then((value) {
        setState(() {
          model.downloaded = true;
          model.name = audioDb.local_path;
        });
      });
    });
    if (await file.exists()) {
      setState(() {
//        localFilePath = file.path;
      });
    }
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
      ]),
    );
  }

  Widget localAsset() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.70 - playerHeight,
          child: ListView.separated
            (
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: files.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ListTile(
                  leading: files[index].downloaded ?Container(width: 0,) :InkWell(
                    child: Icon(Icons.download_rounded, color: Theme.of(context).buttonColor, size: 30,),
                    onTap: (){
                      _loadFile(files[index]);
                      setState(() {
                        files[index].downloaded = true;
                      });
                    },
                  ),
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
//                      audioCache.play(fileName);
                      var sss = Configs.file_ip;
                      if(files[index].downloaded)
                        advancedPlayer.play(fileName);
                      else
                        advancedPlayer.play(sss+fileName);
//                  getDuration();
                      pinPillPosition = MediaQuery.of(context).size.height * 0.001;
                      playerHeight = MediaQuery.of(context).size.height * 0.20;
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
              child: Column(
                children: [
                  Divider(),
                  Container(
//                    margin: EdgeInsets.all(5),
                      height: playerHeight,
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
                                        Text((_position.inMinutes+ (_position.inSeconds.toInt()/60).toInt()).toString().padLeft(2, '0') + ':' + ((_position.inSeconds.round()%60) ).toString().padLeft(2, '0'), style: TextStyle(color: Colors.white),),
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
                                                fileIndex = files.length - 1;
                                              }
                                              else {
                                                fileIndex = fileIndex -1;
                                              }
                                              fileName =files[fileIndex].name;
                                              if(files[fileIndex].downloaded)
                                                advancedPlayer.play(fileName);
                                              else
                                                advancedPlayer.play(Configs.file_ip+fileName);
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
                                              if(files[fileIndex].downloaded)
                                                advancedPlayer.play(fileName);
                                              else
                                                advancedPlayer.play(Configs.file_ip+fileName);
                                            }
                                            else if(advancedPlayer.state == AudioPlayerState.STOPPED){
                                              if(files[fileIndex].downloaded)
                                                advancedPlayer.play(fileName);
                                              else
                                                advancedPlayer.play(Configs.file_ip+fileName);
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
                                                fileIndex = fileIndex + 1;
                                              }
                                              else if(fileIndex >= files.length-1) {
                                                fileIndex = 0;
                                              }
                                              fileName = files[fileIndex].name;
                                              if(files[fileIndex].downloaded)
                                                advancedPlayer.play(fileName);
                                              else
                                                advancedPlayer.play(Configs.file_ip+fileName);
                                              playing = true;

                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )), // first widget
                          ])
                  ),
                ],
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