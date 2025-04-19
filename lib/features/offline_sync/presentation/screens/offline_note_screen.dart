import 'package:drive_notes_app/core/utils/extensions/responsive_extensions.dart';
import 'package:drive_notes_app/features/offline_sync/data/models/content_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _enableEditingProvider = StateProvider<bool>((ref) => false);

class OfflineNoteScreen extends ConsumerStatefulWidget {
  const OfflineNoteScreen({super.key, required this.file});

  final ContentFile file;

  @override
  ConsumerState<OfflineNoteScreen> createState() => _OfflineNoteScreenState();
}

class _OfflineNoteScreenState extends ConsumerState<OfflineNoteScreen> {
  late TextEditingController _textEditingController;
  late String initialContent;

  @override
  void initState() {
    super.initState();
    initialContent = widget.file.content;
    _textEditingController = TextEditingController();
    _textEditingController.text = initialContent;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.file.fileName)),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_textEditingController.text != initialContent &&
                ref.read(_enableEditingProvider)) {
              // showAlertDialog();
            } else {
              ref
                  .read(_enableEditingProvider.notifier)
                  .update((state) => !state);
            }
            String message = "";
            if (ref.read(_enableEditingProvider)) {
              message = "Editing Mode";
            } else {
              message = "Reading Mode";
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          child: Icon(
            ref.watch(_enableEditingProvider)
                ? Icons.edit_rounded
                : Icons.visibility,
            size: context.rs(30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _textEditingController,
            maxLines: null,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ),
    );
  }
}
