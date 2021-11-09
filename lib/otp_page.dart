import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  OTPPage({this.phoneNumber});
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with CodeAutoFill {
  TextEditingController mControllerOtp1 = TextEditingController();
  TextEditingController mControllerOtp2 = TextEditingController();
  TextEditingController mControllerOtp3 = TextEditingController();
  TextEditingController mControllerOtp4 = TextEditingController();
  FocusNode mFocusOtp1 = FocusNode();
  FocusNode mFocusOtp2 = FocusNode();
  FocusNode mFocusOtp3 = FocusNode();
  FocusNode mFocusOtp4 = FocusNode();

  bool otpFocus1;
  bool otpFocus2;
  bool otpFocus3;
  bool otpFocus4;

  StreamController<bool> otpFocusStream1 = new StreamController();
  StreamController<bool> otpFocusStream2 = new StreamController();
  StreamController<bool> otpFocusStream3 = new StreamController();
  StreamController<bool> otpFocusStream4 = new StreamController();

  String appSignature;
  String otpCode;

  static const TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code;
    });
    if (otpCode != null) setControllerText();
  }

  void otpListener() {
    otpFocusStream1.sink.add(false);
    otpFocusStream2.sink.add(false);
    otpFocusStream3.sink.add(false);
    otpFocusStream4.sink.add(false);

    mFocusOtp1.addListener(() {
      if (mFocusOtp1.hasFocus) {
        otpFocus1 = true;
        otpFocusStream1.sink.add(otpFocus1);
        // print(otpFocus1);
      } else {
        otpFocus1 = false;
        otpFocusStream1.sink.add(otpFocus1);
        // print(otpFocus1);
      }
    });

    mFocusOtp2.addListener(() {
      if (mFocusOtp2.hasFocus) {
        otpFocus2 = true;
        otpFocusStream2.sink.add(otpFocus2);
        // print(otpFocus2);
      } else {
        otpFocus2 = false;
        otpFocusStream2.sink.add(otpFocus2);
        // print(otpFocus2);
      }
    });

    mFocusOtp3.addListener(() {
      if (mFocusOtp3.hasFocus) {
        otpFocus3 = true;
        otpFocusStream3.sink.add(otpFocus3);
        // print(otpFocus3);
      } else {
        otpFocus3 = false;
        otpFocusStream3.sink.add(otpFocus3);
        // print(otpFocus3);
      }
    });

    mFocusOtp4.addListener(() {
      if (mFocusOtp4.hasFocus) {
        otpFocus4 = true;
        otpFocusStream4.sink.add(otpFocus4);
        // print(otpFocus4);
      } else {
        otpFocus4 = false;
        otpFocusStream4.sink.add(otpFocus4);
        // print(otpFocus4);
      }
    });
  }

  void otpDispose() {
    mFocusOtp1.dispose();
    mFocusOtp2.dispose();
    mFocusOtp3.dispose();
    mFocusOtp4.dispose();
    otpFocusStream1.close();
    otpFocusStream2.close();
    otpFocusStream3.close();
    otpFocusStream4.close();
  }

  void controllerDispose() {
    mControllerOtp1.dispose();
    mControllerOtp2.dispose();
    mControllerOtp3.dispose();
    mControllerOtp4.dispose();
  }

  setControllerText() {
    mControllerOtp1.text = otpCode.substring(0, 1);
    mControllerOtp2.text = otpCode.substring(1, 2);
    mControllerOtp3.text = otpCode.substring(2, 3);
    mControllerOtp4.text = otpCode.substring(3);
  }

  @override
  void initState() {
    super.initState();
    otpListener();
    listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
        print(appSignature);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    otpDispose();
    cancel();
    SmsAutoFill().unregisterListener();
  }

  @override
  Widget build(BuildContext context) {
    final otp1 = StreamBuilder(
      stream: otpFocusStream1.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: snapshot.data
                  ? Border.all(color: Colors.black, width: 1.5)
                  : Border.all(color: Colors.grey),
            ),
            child: TextField(
              cursorColor: Colors.black,
              keyboardAppearance: Brightness.light,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
              controller: mControllerOtp1,
              focusNode: mFocusOtp1,
              maxLength: 1,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                counterText: "",
              ),
              onChanged: (value) {
                if (value.length > 0) {
                  mFocusOtp2.requestFocus();
                }
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );

    final otp2 = StreamBuilder(
      stream: otpFocusStream2.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: snapshot.data
                  ? Border.all(color: Colors.black, width: 1.5)
                  : Border.all(color: Colors.grey),
            ),
            child: TextField(
                cursorColor: Colors.black,
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                controller: mControllerOtp2,
                focusNode: mFocusOtp2,
                maxLength: 1,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (value) {
                  if (value.length > 0) {
                    mFocusOtp3.requestFocus();
                  } else {
                    mFocusOtp1.requestFocus();
                  }
                }),
          );
        } else {
          return Container();
        }
      },
    );

    final otp3 = StreamBuilder(
      stream: otpFocusStream3.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: snapshot.data
                  ? Border.all(color: Colors.black, width: 1.5)
                  : Border.all(color: Colors.grey),
            ),
            child: TextField(
                cursorColor: Colors.black,
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                controller: mControllerOtp3,
                focusNode: mFocusOtp3,
                maxLength: 1,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (value) {
                  if (value.length > 0) {
                    mFocusOtp4.requestFocus();
                  } else {
                    mFocusOtp2.requestFocus();
                  }
                }),
          );
        } else {
          return Container();
        }
      },
    );

    final otp4 = StreamBuilder(
      stream: otpFocusStream4.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: snapshot.data
                    ? Border.all(color: Colors.black, width: 1.5)
                    : Border.all(color: Colors.grey),
              ),
              child: TextField(
                  cursorColor: Colors.black,
                  keyboardAppearance: Brightness.light,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  controller: mControllerOtp4,
                  focusNode: mFocusOtp4,
                  maxLength: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    counterText: "",
                  ),
                  onChanged: (value) {
                    if (value.length > 0) {
                    } else {
                      mFocusOtp3.requestFocus();
                    }
                  }));
        } else {
          return Container();
        }
      },
    );

    final otpBoxSpace = (MediaQuery.of(context).size.width - 122) / 4;

    final otpFields = Container(
      margin: EdgeInsets.only(left: 66.0, right: 66.0, top: 50),
      child: Row(
        children: <Widget>[
          Expanded(child: otp1),
          SizedBox(width: otpBoxSpace * 0.20),
          Expanded(child: otp2),
          SizedBox(width: otpBoxSpace * 0.20),
          Expanded(child: otp3),
          SizedBox(width: otpBoxSpace * 0.20),
          Expanded(child: otp4),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Enter OTP"),
      ),
      body: Center(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Text(
                  otpCode ?? "OTP Code",
                  style: textStyle,
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  appSignature ?? "No App Signature",
                  style: textStyle,
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.phoneNumber ?? "No Phone Number",
                  style: textStyle,
                )),
            Align(alignment: Alignment.center, child: otpFields),
            Positioned(
                bottom: 100,
                left: 25,
                right: 25,
                child: ElevatedButton(
                    onPressed: () {
                      listenForCode();
                    },
                    child: Text("Resend OTP")))
          ],
        ),
      ),
    );
  }
}
