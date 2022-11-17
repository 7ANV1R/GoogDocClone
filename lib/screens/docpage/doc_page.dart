import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocPage extends ConsumerStatefulWidget {
  const DocPage({required this.id, super.key});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocPageState();
}

class _DocPageState extends ConsumerState<DocPage> {
  TextEditingController titleController = TextEditingController(text: 'Untitled Document');

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.description,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                // width: 200,
                child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ))
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.lock,
                size: 16,
              ),
              label: const Text('Share'),
            ),
          )
        ],
      ),
      body: Center(
        child: Text('Doc ${widget.id}'),
      ),
    );
  }
}
