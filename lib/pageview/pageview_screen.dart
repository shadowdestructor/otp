import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp/login/login.dart';
import 'package:otp/login/name.dart';
import 'package:otp/login/otp.dart';
import 'package:page_transition/page_transition.dart';
import 'slider.dart';

class Pageviewing extends StatefulWidget {
  @override
  _PageviewingState createState() => _PageviewingState();
}

class _PageviewingState extends State<Pageviewing> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
        title: "TEKNOPARK TASK",
        description:
            "Bu uygulama kullanıcının ad,soyadını ve telefon numarası ile giriş yaparak uygulamaya giriş yapma uygulamasıdır.",
        image: ""),
        Namer(),
        Login()
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? Colors.green.shade400
                                : Colors.green.shade400.withOpacity(0.5)));
                  })),
              InkWell(
                onTap: () {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint);
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 300),
                  height: 70,
                  width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                  decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(35)),
                  child: (_currentPage == (_pages.length - 1))
                      ? FlatButton(
                        onPressed: () async {
                          Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 500),
                      child: OTP(codeDigits: dialCodeDigits,phone: tex),
                    ),
                  );
  },
                        child: Text(
                            "Ilerle",
                            style: GoogleFonts.balooThambi(
                              color: Colors.green.shade700,
                              fontSize: 20,
                            ),
                          ),
                      )
                      : Icon(
                          Icons.navigate_next,
                          size: 50,
                          color: Colors.green.shade700,
                        ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}