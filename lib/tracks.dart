import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class Tracks extends StatefulWidget {
  const Tracks({Key? key}) : super(key: key);

  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  void getTracks() async {
    songs =await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        leading: Icon(Icons.music_note,color: Colors.black,),
      title: const Text('Music App',style: TextStyle(
        color: Colors.black
      ),),),

      body: ListView.separated(
          separatorBuilder: (context,index)=>Divider(),
        itemBuilder: (BuildContext context, int index) {  },
        itemCount: null,),
    );
  }
}
