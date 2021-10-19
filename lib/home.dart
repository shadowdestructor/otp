import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp/pageview/pageview_screen.dart';
import 'package:page_transition/page_transition.dart';

//import 'package:dayonemp/login/login.dart';
class Anasayfa extends StatefulWidget {
  Anasayfa({Key? key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  var currentUser = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //brightness: Brightness.dark,
            ),
        home: Scaffold(
          //backgroundColor: Colors.green.shade400,
          body: RefreshIndicator(
            onRefresh: refresh,
            backgroundColor: Colors.green.shade700,
            color: Colors.green.shade400,
            child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Bir Şeyler Yanlış Gitti...',
                            style: GoogleFonts.balooThambi()));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.green.shade700,
                      strokeWidth: 2,
                    ));
                  }
                  return ListView(
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                            contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            title: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 300),
                                    Text(
                                        'Merhaba ${data['ad']} ${data['soyad']}',
                                        style: GoogleFonts.patrickHand()),
                                    Text('Numaranız: ${data['phone']}',
                                        style: GoogleFonts.patrickHand()),
                                        SizedBox(height:25),
                                    Container(
                                      height: 50,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade300,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      
                                      child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2.5,
                                                color: Colors.green.shade700),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: Text(
                                            'Çıkış Yap',
                                            style: GoogleFonts.balooThambi(
                                              color: Colors.green.shade700,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async {
                                            FirebaseAuth.instance.signOut();
                                            Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 500),
                      child: Pageviewing(),
                    ),
                  );
                                          }),
                                    ),
                                  ]),
                            ));
                      },
                    ).toList(),
                  );
                }),
          ),
        ));
  }
}

void onPressed() {}
