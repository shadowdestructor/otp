import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController _namecontroller = TextEditingController();
TextEditingController _surnamecontroller = TextEditingController();



class Namer extends StatefulWidget {
  const Namer({Key? key}) : super(key: key);

  @override
  _NamerState createState() => _NamerState();
}

class _NamerState extends State<Namer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: Text(
              "Sizleri tanıyabilmemiz için Adınızı ve Soyadınızı Girmelsiniz.",
              style: GoogleFonts.patrickHandSc(
                height: 1.5,
                fontWeight: FontWeight.normal,
                fontSize: 18,
                letterSpacing: 0.5,
              )),
        ),
        SizedBox(height: 30),
        Container(
          width: 250,
          child: TextField(
            maxLength: 12,
            autocorrect: true,
            controller: _namecontroller,
            cursorColor: Colors.green.shade400,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
              helperText: 'Adınızı doğru bir biçimde yazınız.',
              helperStyle: GoogleFonts.balooThambi(),
              fillColor: Colors.green.shade400,
              hoverColor: Colors.green.shade400,
              focusColor: Colors.green.shade400,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade400, width: 2),
              ),
              suffixIcon: Icon(
                Icons.person_outlined,
                color: Colors.green.shade400,
              ),
              labelText: 'Ad',
              labelStyle: TextStyle(color: Colors.green.shade400),
              hintText: 'Adınızı Yazınız...',
              hintStyle: TextStyle(
                color: Colors.green.shade400,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 250,
          child: TextField(
            maxLength: 12,
            autocorrect: true,
            controller: _surnamecontroller,
            cursorColor: Colors.green.shade400,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
              helperText: 'Soyadınızı doğru bir biçimde yazınız.',
              helperStyle: GoogleFonts.balooThambi(),
              fillColor: Colors.green.shade400,
              hoverColor: Colors.green.shade400,
              focusColor: Colors.green.shade400,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade400, width: 2),
              ),
              suffixIcon: Icon(
                Icons.person_outline_outlined,
                color: Colors.green.shade400,
              ),
              labelText: 'Soyad',
              labelStyle: TextStyle(color: Colors.green.shade400),
              hintText: 'Soyadınızı Yazınız...',
              hintStyle: TextStyle(
                color: Colors.green.shade400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String name = _namecontroller.text;
String surname = _surnamecontroller.text;