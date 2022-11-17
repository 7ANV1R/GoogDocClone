import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocPage extends ConsumerStatefulWidget {
  const DocPage({required this.id, super.key});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocPageState();
}

class _DocPageState extends ConsumerState<DocPage> {
  TextEditingController titleController = TextEditingController(text: 'Untitled Document');
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            quill.QuillToolbar.basic(controller: _controller),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SizedBox(
                width: size.width * 0.7,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: quill.QuillEditor.basic(
                      controller: _controller,
                      readOnly: false, // true for view only mode
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
