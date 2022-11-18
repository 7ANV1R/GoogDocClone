import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/models/doc_model.dart';
import 'package:googdocc/models/error_model.dart';
import 'package:googdocc/repository/auth_repository.dart';
import 'package:googdocc/repository/doc_repository.dart';

class DocPage extends ConsumerStatefulWidget {
  const DocPage({required this.title, required this.id, super.key});
  final String id;
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocPageState();
}

class _DocPageState extends ConsumerState<DocPage> {
  late TextEditingController titleController;
  final quill.QuillController _controller = quill.QuillController.basic();
  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    fetchDocData();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  fetchDocData() async {
    errorModel = await ref.read(docRepoProvider).getDocByID(ref.read(userProvider)!.token, widget.id);
    if (errorModel!.data != null) {
      setState(() {
        titleController.text = (errorModel!.data as DocModel).title;
      });
    }
  }

  void updateTitle(String title) {
    ref.read(docRepoProvider).updateTitle(token: ref.read(userProvider)!.token, id: widget.id, title: title);
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
              onSubmitted: (value) => updateTitle(titleController.text),
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
