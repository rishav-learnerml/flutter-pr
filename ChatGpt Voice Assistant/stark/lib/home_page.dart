import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:stark/feature_box.dart';
import 'package:stark/openai_service.dart';
import 'package:stark/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText sp = SpeechToText();
  FlutterTts ft = FlutterTts();
  String lastWords = '';
  final OpenAIService os = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initSpeechToText() async {
    await sp.initialize();
    setState(() {});
  }

  Future<void> initTextToSpeech() async {
    await ft.setSharedInstance(true);
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await sp.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await sp.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await ft.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    sp.stop();
    ft.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(child: const Text('Stark')),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //virtual assistant avatar
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Container(
                    height: 130,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/VirtualAssistant.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 40)
                      .copyWith(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      generatedContent == null
                          ? 'Take a bow, Avenger! What can I do for you?'
                          : generatedContent!,
                      style: TextStyle(
                          color: Pallete.mainFontColor,
                          fontSize: generatedContent == null ? 25 : 18,
                          fontFamily: 'Cera Pro'),
                    ),
                  ),
                ),
              ),
            ),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(generatedImageUrl!),
                ),
              ),

            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 22),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "What's here?",
                    style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Pallete.mainFontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            //suggestions list
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(microseconds: start),
                    child: const FeatureBox(
                      color: Pallete.firstSuggestionBoxColor,
                      headerText: 'ChatGpt',
                      descriptionText:
                          "It's not only the hype!! It's a smarter way to stay organised and informed with ChatGpt!",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(microseconds: start + delay),
                    child: const FeatureBox(
                      color: Pallete.secondSuggestionBoxColor,
                      headerText: 'Dall-E',
                      descriptionText:
                          "Inspiring and Creative as always!! Just like YOU! Powered by Dall-E",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(microseconds: start + 2 * delay),
                    child: const FeatureBox(
                      color: Pallete.thirdSuggestionBoxColor,
                      headerText: 'Smart Voice Assistant',
                      descriptionText:
                          "Get the power of both voice and image with me - Stark, your personal assistant, powered by ChatGpt and Dall-E",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(microseconds: start + 3 * delay),
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: () async {
            if (await sp.hasPermission && sp.isNotListening) {
              await startListening();
            } else if (sp.isListening) {
              final speech = await os.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(sp.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
