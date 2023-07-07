

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writer_app/controller/books_draft_controller.dart';
import 'package:writer_app/pages/edit_draft_page.dart';

class DraftPage extends StatefulWidget {
   final draftHeaderSaved;
   final String draftTextSaved;
   DraftPage({Key? key, required this.draftTextSaved, required this.draftHeaderSaved}) : super(key: key);

  @override
  State<DraftPage> createState() => _DraftPageState();
}

class _DraftPageState extends State<DraftPage> {

  @override
  Widget build(BuildContext context) {
    final draftsProvider = Provider.of<BooksDraftController>(context);
    return   Scaffold(
      appBar: AppBar(
        title: Text('Draft'),
      ),
      body: GridView.builder(
        itemCount: draftsProvider.drafts.length,
        itemBuilder: (context, index) {
          final draft = draftsProvider.drafts[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:  BoxDecoration(
                  border: Border.all(
                      width: 3.0,
                    color: Colors.indigo
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0)
                  ),
              ),
              child: ListTile(
                title: Text(draft.header),
                subtitle: Text(draft.body),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditDraftScreen(draft: draft),
                    ),
                  );
                },
              ),
            ),
          );
        }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      ),
    );
  }
}