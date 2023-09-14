import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:genuine_app/screens/journal.dart';
import 'package:genuine_app/widgets/journal/controller/journal_controller.dart';
import 'package:genuine_app/widgets/journal/journal_image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputJournal extends ConsumerStatefulWidget {
  const InputJournal({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(
        builder: (context) => const InputJournal(),
      );

  /*static routeForJournal() => MaterialPageRoute(
        builder: (context) => const JournalScreen(),
      );*/

  //const InputJournal({super.key});

  /*
  @override
  State<InputJournal> createState() {
    return _InputJournalState();
  }
  */
  @override
  InputJournalState createState() {
    return InputJournalState();
  }
}

class InputJournalState extends ConsumerState<InputJournal> {
  final inputJournalController = TextEditingController();
  bool _enableJournal1 = false;
  bool _enableJournal2 = false;
  bool _enableNone = false;
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    inputJournalController.dispose();
  }

  void shareJournal() {
    ref.read(journalControllerProvider.notifier).shareJournal(
          images: images,
          text: inputJournalController.text,
          context: context,
        );
    Navigator.pop(context);
    /*Navigator.push(
    context,
    InputJournal.routeForJournal());*/
  }

  void onPickImages() async {
    List<File> pickedImages = await pickImages();
    for (File image in pickedImages) {
      images.add(image);
    }
    setState(() {});
  }

  void onTakeImage() async {
    File imageTaken = await takeImage();
    images.add(imageTaken);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(journalControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[300],
                  ),
                  width: 65,
                  height: 40,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: shareJournal,
                    child: Text(
                      'Draft',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  
                  width: 65,
                  height: 40,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: shareJournal,
                    child: Text(
                      'Post',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : SafeArea(
              child: SingleChildScrollView(
                //margin: const EdgeInsets.symmetric(horizontal: 20),
                //color: Colors.blue,
                child: Column(children: [
                  Container(
                    height: 500,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      controller: inputJournalController,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Start writing...",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  ),
                  if (images.isNotEmpty)
                    CarouselSlider(
                      items: images.map(
                        (file) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(5),
                              child: Image.file(file));
                        },
                      ).toList(),
                      options: CarouselOptions(
                        height: 150,
                        enableInfiniteScroll: false,
                      ),
                    ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.camera_alt_outlined),
                        SizedBox(width: 10),
                        Text(
                          'Photo',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: onTakeImage,
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                          ),
                          icon: const Icon(Icons.camera_alt),
                          label: Text(
                            'Take Photo',
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton.icon(
                          onPressed: onPickImages,
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                          ),
                          icon: const Icon(Icons.image),
                          label: Text(
                            'From Gallery',
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.group_outlined),
                        SizedBox(width: 10),
                        Text(
                          'Which shared-journal would you like to share?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Jimmy & Giannis\'s Journal',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Switch(
                              value: _enableJournal1,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              onChanged: (value) {
                                setState(() {
                                  _enableJournal1 = value;
                                  if (_enableNone) {
                                    _enableNone = false;
                                  }
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Jimmy & Taytum\'s Journal',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Switch(
                              value: _enableJournal2,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              onChanged: (value) {
                                setState(() {
                                  _enableJournal2 = value;
                                  if (_enableNone) {
                                    _enableNone = false;
                                  }
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Do not share with anyone',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Switch(
                              value: _enableNone,
                              activeColor: Colors.red[600],
                              onChanged: (value) {
                                setState(() {
                                  _enableJournal1 = false;
                                  _enableJournal2 = false;
                                  _enableNone = value;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
      /*bottomNavigationBar: Container(
        height: 100,
        child: InkWell(
          onTap: shareJournal,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ),
                const Text('Post'),
              ],
            ),
          ),
        ),
      ),*/
    );
  }
}
