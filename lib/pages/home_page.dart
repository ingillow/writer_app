import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:writer_app/controller/books_draft_controller.dart';
import 'package:writer_app/controller/settings_app_controller.dart';
import 'package:writer_app/pages/draft_page.dart';
import 'package:writer_app/pages/settings_page.dart';

class Style{
  static Color iconColors = Color(15);
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var settings = Provider.of<SettingsAppController>(context);
    var booksController = Provider.of<BooksDraftController>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.deepPurple,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.deepPurple,
                  size: 28,
                ),
                onPressed: () {
                  booksController.saveText(booksController.editingController.text);
                },
              )
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          Consumer<SettingsAppController>(
            builder: (context, colorProvider, _) {
              if (colorProvider.useColor) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: colorProvider.color,
                );
              } else {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(colorProvider.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
          ), Positioned.fill(
              child: Column(
                children: [
                  TextField(
                    controller: booksController.editingControllerHeader,
                    decoration: InputDecoration(hintText: "Insert your head",),
                    scrollPadding: EdgeInsets.all(20.0),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    autofocus: true,
                    autocorrect: true,
                  ),
                  TextField(
                    controller: booksController.editingController,
                    decoration: InputDecoration.collapsed(hintText: 'Body'),
                    scrollPadding: EdgeInsets.all(20.0),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    autofocus: true,
                    autocorrect: true,
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DraftPage(
              draftTextSaved:
              booksController.editingController.text,
              draftHeaderSaved:
              booksController.editingControllerHeader.text,
            )),
      ); },),
    );
  }
}
