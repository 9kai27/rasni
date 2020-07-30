import 'package:flutter/material.dart';
//Package for make icon.
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
//Package fot make link. 
import 'package:url_launcher/url_launcher.dart';
//Package fot NoSQL Database.
import 'package:shared_preferences/shared_preferences.dart';

//constitution
//main->Myapp->AppMain->_AppMainState
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rasni',
      theme: ThemeData.dark(),
      home: AppMain(title: 'AppName'),
    );
  }
}

class AppMain extends StatefulWidget {
  AppMain({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Visibility(
        visible: isLoaded,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(''),
              TextField(
                controller: memoController,
                onChanged: (text) {
                  save('memo', text);
                },
                minLines: 27,
                maxLines: 27,
                maxLength: 500,
                style: TextStyle(fontSize: 33.0 ,color: Colors.yellow),
                maxLengthEnforced: true,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.yellow, width: 0.1),
                    ),
                  hintText: 'To RAS',
                  hintStyle: TextStyle(color: Colors.yellow),
                  )
            ),
              //Link
              RaisedButton(
                onPressed: _launchURL,
                color: Colors.yellow,
                child: Text('ABOUT',
                  style: TextStyle(
                    color:Colors.black
                  ),
                ),
              )
            ]
          ),
        )
      ),
    );
  }

  //These code is not need after widget.
  //No problem even before the widget.
  //However, do not write it outside of _AppMainState~{}.
  //link configuration https://pub.dev/packages/link
  _launchURL() async {
    const url = 'https://9vox2.netlify.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  //Controller for data.
  final memoController = TextEditingController();
  var isLoaded = false;

  //Prepare for data load.
  @override
  void initState() {
    super.initState();
    load();
  }

  //Function of data load.
  Future<void> load() async {
    final prefs1 = await SharedPreferences.getInstance();
    memoController.text = prefs1.getString('memo');
    setState(() {
      isLoaded = true;
    });
    }

  //Function of data save.
  Future<void> save(key, text) async {
    final prefs2 = await SharedPreferences.getInstance();
    await prefs2.setString(key, text);
    setState(() {
      isLoaded = true;
    });
  }

}