import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsDemoScreen extends StatefulWidget {
  const TtsDemoScreen({Key? key}) : super(key: key);

  @override
  State<TtsDemoScreen> createState() => _TtsDemoScreenState();
}

class _TtsDemoScreenState extends State<TtsDemoScreen> {

  late FlutterTts flutterTts = FlutterTts();
  List<Map<String, String>> allVoices = [];

  @override
  void initState() {
    initTts();
    getAllVoices();
    super.initState();
  }

  initTts() async{
    await flutterTts.setLanguage('en-US');
  }

  Future<void> getAllVoices() async {
    //String languagePrefix = _language.substring(0, 2).toLowerCase();
    var voices = await flutterTts.getVoices;
    if (voices != null) {
      allVoices = voices.map<Map<String, String>>((voice) {
        return Map<String, String>.from(voice as Map);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(title: const Text('TTS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), backgroundColor: Colors.teal,),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: allVoices.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  const SizedBox(height: 15,),
                ElevatedButton(
                    onPressed: () async{
                  await flutterTts.setVoice(allVoices[index]);
                  await flutterTts.speak('This is a demo for text to speech');
                }, child: Center(child: Text('Voice$index'),)),
                const SizedBox(height: 15,)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

