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
          onPressed: () {Navigator.pop(context);},
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          Material(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: () {
                
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 60,
                height: 30,
                alignment: Alignment.center,
                child: const Text(
                  'Post',
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
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
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
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
