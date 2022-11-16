import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocPage extends ConsumerStatefulWidget {
  const DocPage({required this.id, super.key});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocPageState();
}

class _DocPageState extends ConsumerState<DocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Doc ${widget.id}'),
      ),
    );
  }
}
