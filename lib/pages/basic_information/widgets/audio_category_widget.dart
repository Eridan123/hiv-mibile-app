import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'ex_audio.dart';
import '../../../db/audio_db.dart';
import '../../../db/db_provider.dart';

class AudioCategoryWidget extends StatefulWidget {
  @override
  _AudioCategoryWidgetState createState() => _AudioCategoryWidgetState();
}

class _AudioCategoryWidgetState extends State<AudioCategoryWidget> {

  List<AudioCategoryModel> _list = new List<AudioCategoryModel>();
  List<AudioDb> _dbList = new List<AudioDb>();
  bool showAudios = false;
  int index;

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    else{
      return false;
    }
  }

  getListOfAudios() async {
    _checkInternetConnection().then((value) async {
      if(value) {
        await AudioFileModel.getList().then((value) {
          setState(() {
            _list.addAll(value);
          });
        });
      }
      else{
        List<AudioCategoryModel> list = new List<AudioCategoryModel>();
        await DBProvider.db.getAudioFilesGroupByCategories().then((value) async {
          for(var i in value){
            AudioCategoryModel model = new AudioCategoryModel();
            List<AudioFileModel> modelFiles = new List<AudioFileModel>();
            model.category_name = i;
            await DBProvider.db.getAudioFilesByCategories(i).then((value) {
              for(var j in value){
                AudioFileModel model1 = new AudioFileModel(title: j.title, name: j.local_path, downloaded: true);
                modelFiles.add(model1);
              }
            });
            model.audios = modelFiles;
            list.add(model);
          }
          setState(() {
            _list.addAll(list);
          });
        });
      }
    });
  }

  getListFromDatabase() async{
    await DBProvider.db.getAllAudioFiles().then((value) {
      setState(() {
        _dbList.addAll(value);
      });
    });
  }

  @override
  void initState() {
    getListOfAudios();
    getListFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: showAudios?
      Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.04, MediaQuery.of(context).size.width * 0.04, 0, 0),
            alignment: Alignment.topLeft,
            child: InkWell(
              child: Text('back'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: (){
                setState(() {
                  showAudios = false;
                });
              },
            ),
          ),
          AudioApp(list: _list[index].audios, dbList: _dbList, category_name: _list[index].category_name,),
        ],
      ):
      Container(
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * 0.04, 0, 0),
        child: ListView.separated(
          shrinkWrap: true,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(
                  _list[index].category_name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                  onTap: () {
                    setState(() {
                      showAudios = true;
                      this.index = index;
                    });
                  }
              );
            },
            separatorBuilder: (context, index){
              return Divider();
            },
            itemCount: _list.length),
      ),
    );;
  }
}
