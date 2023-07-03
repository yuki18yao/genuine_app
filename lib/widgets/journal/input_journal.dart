import 'package:flutter/material.dart';

class InputJournal extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const InputJournal(),
      );

  const InputJournal({super.key});

  @override
  State<InputJournal> createState() {
    return _InputJournalState();
  }
}

class _InputJournalState extends State<InputJournal> {
  final inputJournalController = TextEditingController();
  bool _enableJournal1 = false;
  bool _enableJournal2 = false;
  bool _enableNone = false;

  @override
  void dispose() {
    super.dispose();
    inputJournalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Material(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 60,
                  height: 35,
                  alignment: Alignment.center,
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          //margin: const EdgeInsets.symmetric(horizontal: 20),
          //color: Colors.blue,
          child: Column(children: [
            Container(
              height: 400,
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
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.3,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: const Row(
                children: [
                  Icon(Icons.group_outlined),
                  SizedBox(width: 10),
                  Text(
                    'Which shared-journal would you like to share?',
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Weiyi & Yuki\'s Journal',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Switch(
                        value: _enableJournal1,
                        activeColor: Theme.of(context).colorScheme.primary,
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
                        'Ryosei & Yuki\'s Journal',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Switch(
                        value: _enableJournal2,
                        activeColor: Theme.of(context).colorScheme.primary,
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
                        activeColor: Theme.of(context).colorScheme.primary,
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
      bottomNavigationBar: Container(
        height: 100,
        child: InkWell(
          onTap: () {},
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
      ),
    );
  }
}
