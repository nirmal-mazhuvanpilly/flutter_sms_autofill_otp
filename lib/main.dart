import 'package:flutter/material.dart';
import 'package:sms_auto_fill/otp_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'SMS Auto Fill'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  final snackBar = SnackBar(content: Text("Enter 10 digit phone Number"));

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  nextScreen(BuildContext context) {
    if (textController.text.length == 10) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPPage(phoneNumber: textController.text),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey[350],
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: "Enter 10 digit Phone Number",
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  nextScreen(context);
                },
                child: Text("Send OTP"))
          ],
        ),
      ),
    );
  }
}
