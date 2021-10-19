import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp/home.dart';
import 'package:otp/login/name.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTP extends StatefulWidget {
  final String phone;
  final String codeDigits;
  OTP({required this.phone, required this.codeDigits});

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  User? user = FirebaseAuth.instance.currentUser;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pincontroller = TextEditingController();
  final FocusNode _pinOTP = FocusNode();
  String? varcode;

  final BoxDecoration pinOTPDec = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.green.shade700, width: 3));

  void initState() {
    super.initState();

    verifyphonenumber();
  }

  verifyphonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${widget.codeDigits + widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            
            Navigator.of(context).push(MaterialPageRoute(
                builder: (c) => OTP(
                      codeDigits: widget.codeDigits,
                      phone: widget.phone,
                    )));
          }
          await FirebaseFirestore.instance
                .collection("users")
                .doc(user!.uid)
                .set({'userid': user!.uid,
                "ad" : name,
                "soyad": surname,
                "phone": '${widget.codeDigits + widget.phone}'
});
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message.toString()),
          duration: Duration(seconds: 3),
        ));
      },
      codeSent: (String? vID, int? resentToken) {
        setState(() {
          varcode = vID;
        });
      },
      codeAutoRetrievalTimeout: (String? vID) {
        setState(() {
          varcode = vID;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        color: Colors.green.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green.shade700,
                  width: 4,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              alignment: Alignment.center,
              width: 300,
              height: 72,
              child: Text(
                "Teknopark",
                style: GoogleFonts.balooThambi(
                  color: Colors.green.shade700,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              alignment: Alignment.center,
              width: 300,
              height: 72,
              child: Text(
                "Teknopark",
                style: GoogleFonts.balooThambi(
                  color: Colors.green.shade400,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    verifyphonenumber();
                  },
                  child: Text(
                    '${widget.codeDigits}-${widget.phone} numarasına\ngönderdiğimiz kodu buraya giriniz ve ardından giriş yapabilirsiniz.',
                    style: GoogleFonts.balooThambi(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green.shade700),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(40),
                child: PinPut(
                  fieldsCount: 6,
                  textStyle: GoogleFonts.balooThambi(
                      fontSize: 25, color: Colors.green.shade700),
                  eachFieldWidth: 40,
                  eachFieldHeight: 55,
                  focusNode: _pinOTP,
                  controller: _pincontroller,
                  submittedFieldDecoration: pinOTPDec,
                  selectedFieldDecoration: pinOTPDec,
                  followingFieldDecoration: pinOTPDec,
                  pinAnimationType: PinAnimationType.scale,
                  onSubmit: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: varcode!, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (c) => Anasayfa()));
                          await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
                            'userid': user!.uid,
                "ad" : name,
                "soyad": surname,
                "phone": '${widget.codeDigits + widget.phone}'
                          });
                        }
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invalid OTP"),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}