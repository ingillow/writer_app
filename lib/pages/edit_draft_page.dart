import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writer_app/controller/books_draft_controller.dart';
import 'package:writer_app/models/books_draft.dart';

class EditDraftScreen extends StatefulWidget {
  final BooksDraft draft;

  EditDraftScreen({required this.draft});

  @override
  _EditDraftScreenState createState() => _EditDraftScreenState();
}

class _EditDraftScreenState extends State<EditDraftScreen> {
  late TextEditingController _headerController;
  late TextEditingController _bodyController;
  late TextEditingController _coverController;

  @override
  void initState() {
    super.initState();
    _headerController = TextEditingController(text: widget.draft.header);
    _bodyController = TextEditingController(text: widget.draft.body);
    _coverController = TextEditingController(text: widget.draft.cover);
  }

  @override
  void dispose() {
    _headerController.dispose();
    _bodyController.dispose();
    _coverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Draft'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _headerController,
              decoration: InputDecoration(hintText: 'Header'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(hintText: 'Body'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _coverController,
              decoration: InputDecoration(hintText: 'Cover'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final updatedDraft = BooksDraft(
                  header: _headerController.text,
                  body: _bodyController.text,
                  cover: _coverController.text,
                  id: -1
                );
                final draftsProvider = Provider.of<BooksDraftController>(context, listen: false);
                draftsProvider.saveDraft(updatedDraft);
                Navigator.pop(context); // Go back to the draft list screen
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
