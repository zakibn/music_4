// Make a Music streaming app using Flutter
//  doctor code
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_4/components/custom_list_title.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  const MusicApp({super.key});

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List musicList = [
    {
      'title': "Tech house vibes",
      'singer': "Alejandro magana",
      'url': "https://assets.mixkit.co/music/preview/mixkit",
      'coverUrl': "https://assets.mixkit.co/music/preview/mixkit",
    },
    {
      'title': " house vibes",
      'singer': " magana",
      'url': "https://assets.mixkit.co/music/preview/mixkit",
      'coverUrl':
          "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimg.freepik.com%2Fphotos-gratuite%2Fparcs-montagnes-reflexion-jardin-decoration-montagne_1417-1025.jpg%3Fw%3D2000&imgrefurl=https%3A%2F%2Ffr.freepik.com%2Fphotos%2Fnature&tbnid=XRQJNLBGuq9fyM&vet=12ahUKEwiXyYyywYr7AhWEgc4BHSlzCXEQMygfegUIARDqAQ..i&docid=ZUPprtrIYSg2DM&w=2000&h=959&q=image%20nateur&client=firefox-b-lm&ved=2ahUKEwiXyYyywYr7AhWEgc4BHSlzCXEQMygfegUIARDqAQ",
    },
    {},
    {},
    {},
    {},
    {},
    {},
    {},
  ];

  String currentTitle = "";
  String currentCover = "";
  String currentSinger = "";
  IconData btnIcon = Icons.play_arrow;

  /////
  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentSong = "";

  //// خاص بالسيك بار والتحرك تاعو
  Duration duration = new Duration();
  Duration position = new Duration();
  //////  نهاية سيك بار

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btnIcon = Icons.play_arrow;
        });
      }
      //// خاص بالسيك بار
      audioPlayer.onDurationChanged.listen((event) {
        setState(() {
          duration = event;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((event) {
        setState(() {
          position = event;
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'My PlayList',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: ((context, index) => customListTile(
                      onTab: () {
                        playMusic(musicList[index]['url']);
                        // عندما يختار من الليست فيو روح هز العنوان والمغني وحطهم ف السيك بار و الخ
                        setState(() {
                          currentTitle = musicList[index]['title'];
                          currentCover = musicList[index]['coverUrl'];
                          currentSinger = musicList[index]['singer'];
                        });
                      },
                      title: musicList[index]['title'],
                      singer: musicList[index]['singer'],
                      cover: musicList[index]['coverUrl'],
                    )),
              ),
            ),
            ///////////الجزء السفلي تاع السيك بار و
            Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color(0x55212121),
                    //الظل فوق السيك بار
                    blurRadius: 8.0),
              ]),
              child: Column(children: [
                // السيك بار
                Slider.adaptive(
                    value: position.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: ((value) {})),

                //// صورة وعنوان الاغنية التي تم الضغط عليها التي تظهر ف الاسفل
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            image: DecorationImage(
                                image: NetworkImage(currentCover))),
                      ),
                      const SizedBox(
                        width: 10.0,
                      )
                      // عنوان و الفنان لل  الاغنية التي تم الضغط عليها التي تظهر ف الاسفل
                      ,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //عنوان الاغنية
                            Text(
                              currentTitle,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // الفراغ بين اسم الاغنية والفنان
                            const SizedBox(
                              height: 5.0,
                            ),
                            //اسم الفنان
                            Text(
                              currentSinger,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      // زر الايقاف و التشغيل للاغنية
                      const IconButton(
                        onPressed: () {
                          if (isPlaying) {
                            audioPlayer.pause();
                            setState(() {
                              btnIcon = Icons.pause;
                              isPlaying = false;
                            });
                          } else {
                            audioPlayer.resume();
                            setState(() {
                              btnIcon = Icons.play_arrow;
                              isPlaying = true;
                            });
                          }
                        },
                        iconSize: 42.0,
                        icon: Icon(btnIcon),
                      )
                    ],
                  ),
                ),
              ]
                  ///////////////
                  ),
            )
          ],
        ),
      );
    }
  }
}
