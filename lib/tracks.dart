import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'main.dart';
import 'music_player.dart';


class Tracks extends StatefulWidget {
  _TracksState createState()=>_TracksState();
}
class _TracksState extends State<Tracks> {
  final FlutterAudioQuery audioQuery=FlutterAudioQuery();
  List<SongInfo> songs=[];
  int currentIndex=0;
  final GlobalKey<MusicPlayerState> key=GlobalKey<MusicPlayerState>();
  void initState()  {
    super.initState();
    getTracks();
  }

  void getTracks() async  {
    songs=await audioQuery.getSongs();
    setState(() {
      songs=songs;
    });
  }
  void changeTrack(bool isNext) {
    if(isNext)  {
      if(currentIndex!=songs.length-1)  {
        currentIndex++;
      }
    } else  {
      if(currentIndex!=0) {
        currentIndex--;
      }
    }
    key.currentState?.setSong(songs[currentIndex]);
  }
  Widget build(context) {
    MaterialColor mycolor = MaterialColor(0xFFe3cea6, color);
    return Scaffold(
      appBar: AppBar(backgroundColor: mycolor ,leading: Icon(Icons.music_note,color: Colors.black),
        title: Text('Music App', style: TextStyle(color: Colors.black,fontSize: 25)),),
      body: ListView.separated(separatorBuilder:(context,index)=>SizedBox(height: 10, child: Divider(thickness: 3,color: mycolor),),
        itemCount: songs.length,
        // itemBuilder: (context,index)=>ListTile(leading: CircleAvatar(backgroundImage: songs[index].albumArtwork==null?AssetImage('assets/images/background.jpg'):FileImage(File(songs[index].albumArtwork)),),
        itemBuilder: (context,index)=>ListTile(leading: CircleAvatar(backgroundImage: AssetImage('assets/images/background.jpg')),
        title: Text(songs[index].title),subtitle: Text(songs[index].artist),onTap: ()  {
        currentIndex=index;
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MusicPlayer(changeTrack: changeTrack,songInfo: songs[currentIndex],key: key)));
      },),),
    );
  }
}