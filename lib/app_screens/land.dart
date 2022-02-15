// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wave_dev/app_screens/audio_page.dart';
import 'package:wave_dev/app_screens/emotion.dart';
import 'package:wave_dev/app_screens/login.dart';
import 'package:wave_dev/app_screens/Profile.dart';
import 'package:wave_dev/app_screens/listpage.dart';
import 'package:wave_dev/app_screens/tabs.dart';
import 'package:wave_dev/app_screens/camera_controll.dart';

class land extends StatefulWidget {
  const land({Key? key}) : super(key: key);

  @override
  _landState createState() => _landState();
}

///////////////////////List error

class _landState extends State<land> with SingleTickerProviderStateMixin {
  var songs;
  var mal;
  var hindi;
  var tamil;

  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json_files/songs.json")
        .then((s) {
      setState(() {
        songs = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json_files/mal.json")
        .then((s) {
      setState(() {
        mal = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json_files/hindi.json")
        .then((s) {
      setState(() {
        hindi = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json_files/tamil.json")
        .then((s) {
      setState(() {
        tamil = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  /* User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(

        //bottomNavigationBar: AppBar(),
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.black,
                body: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ImageIcon(AssetImage("assets/trend.png"),
                                    size: 24, color: Colors.white70),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )
                                    //SizedBox(width: 10,),
                                    //Icon(Icons.notifications),
                                  ],
                                )
                              ])),
                      //////////
                      SizedBox(
                        height: 20,
                      ),
                      ///////////
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 25),
                              child: Text("Crushers",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Lora',
                                      color: Colors.white)))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ////////////////////////////////////scrollviewcontroller
                      Container(
                        height: 180,
                        child: Stack(children: [
                          Positioned(
                              top: 0,
                              left: -18,
                              right: 0,
                              child: Container(
                                height: 180,
                                child: PageView.builder(
                                    controller:
                                        PageController(viewportFraction: 0.8),
                                    itemCount: songs == null ? 0 : songs.length,
                                    itemBuilder: (_, i) {
                                      return Container(
                                        height: 180,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image:
                                                  AssetImage(songs[i]["img"]),
                                              fit: BoxFit.fill,
                                            )),
                                      );
                                    }),
                              ))
                        ]),
                      ),
                      Expanded(
                          child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool isScroll) {
                          return [
                            SliverAppBar(
                                backgroundColor: Colors.black,
                                pinned: true,
                                bottom: PreferredSize(
                                  preferredSize: Size.fromHeight(50),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: TabBar(
                                        indicatorPadding:
                                            const EdgeInsets.all(0),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,

                                        labelPadding: const EdgeInsets.only(
                                            left: 20, right: 0),
                                        labelColor: Colors.black,
                                        controller: _tabController,
                                        isScrollable: true,
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  blurRadius: 7,
                                                  offset: Offset(0, 0))
                                            ]),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        tabs: [
//The 3 containers in home screen
                                          AppTabs(
                                            color: Colors.red,
                                            text: "Mal",
                                          ),
                                          AppTabs(
                                              color: Colors.red, text: "Hindi"),
                                          AppTabs(
                                              color: Colors.red, text: "Eng"),
                                          AppTabs(
                                              color: Colors.red, text: "Tamil"),
                                        ],
                                      )),
                                ))
                          ];
                        },
//children for tabbarview
                        body: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                                itemCount: mal == null ? 0 : mal.length,
                                itemBuilder: (_, i) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Audio_Page(
                                                        audioPath: mal,
                                                        index: i)));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black26,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  offset: Offset(0, 0),
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                )
                                              ]),
                                          child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                mal[i]
                                                                    ["img"]))),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          mal[i]["title"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          mal[i]["text"],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 13),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            color: Colors.red,
                                                          ),
                                                          child: Text(
                                                            "prem",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Avenir",
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                        )
                                                      ])
                                                ],
                                              )),
                                        ),
                                      ));
                                }),
                            ////////////////////////////////////////

                            ListView.builder(
                                itemCount: hindi == null ? 0 : hindi.length,
                                itemBuilder: (_, i) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Audio_Page(
                                                        audioPath: hindi,
                                                        index: i)));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black26,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  offset: Offset(0, 0),
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                )
                                              ]),
                                          child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                hindi[i]
                                                                    ["img"]))),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          hindi[i]["title"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          hindi[i]["text"],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 13),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            color: Colors.red,
                                                          ),
                                                          child: Text(
                                                            "prem",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Avenir",
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                        )
                                                      ])
                                                ],
                                              )),
                                        ),
                                      ));
                                }),

                            ////////////////////////////////////
                            ListView.builder(
                                itemCount: mal == null ? 0 : mal.length,
                                itemBuilder: (_, i) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Audio_Page(
                                                        audioPath: mal,
                                                        index: i)));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black26,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  offset: Offset(0, 0),
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                )
                                              ]),
                                          child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                mal[i]
                                                                    ["img"]))),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          mal[i]["title"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          mal[i]["text"],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 13),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            color: Colors.red,
                                                          ),
                                                          child: Text(
                                                            "prem",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Avenir",
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                        )
                                                      ])
                                                ],
                                              )),
                                        ),
                                      ));
                                }),
                            ///////////////
                            ///
                            ListView.builder(
                                itemCount: tamil == null ? 0 : tamil.length,
                                itemBuilder: (_, i) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Audio_Page(
                                                        audioPath: tamil,
                                                        index: i)));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black26,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  offset: Offset(0, 0),
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                )
                                              ]),
                                          child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                tamil[i]
                                                                    ["img"]))),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          tamil[i]["title"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          tamil[i]["text"],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 13),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            color: Colors.red,
                                                          ),
                                                          child: Text(
                                                            "prem",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Avenir",
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                        )
                                                      ])
                                                ],
                                              )),
                                        ),
                                      ));
                                }),
                          ],
                        ),
                      ))

                      ////////////////////Check the children after final break up///////////
                      //////////////////////////BOTTOM BUTTON CONTAINER STARTING POINT///////
//////////////////////////////Dont go unless needed///////////////////////////////////////////////////////////////////
                      ,
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.home),
                                  color: Colors.white,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  iconSize: 30,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await availableCameras().then(
                                      (value) => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CameraPage(
                                                  cameras: value,
                                                )),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.play_arrow),
                                  iconSize: 30,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  color: Colors.blue,
                                  alignment: Alignment.bottomRight,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ListPage()));
                                  },
                                  icon: Icon(Icons.celebration_rounded),
                                  color: Colors.red,
                                  iconSize: 30,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                IconButton(
                                  onPressed: () {
                                    _popup(context);
                                  },
                                  icon: Icon(Icons.menu_open),
                                  color: Colors.yellow,
                                  iconSize: 30,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  alignment: Alignment.topRight,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }

  void _popup(context) {
    showModalBottomSheet(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (BuildContext bc) {
          return Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
              height: MediaQuery.of(context).size.height * .30,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.person_outline,
                              size: 25,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profileView()));
                            },
                            child: Text("My Account",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Lora',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.settings,
                              size: 25,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          Text("Settings",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.info,
                              size: 25,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          Text("About",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.logout,
                              size: 25,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              logout(context);
                            },
                          ),
                          ActionChip(
                            label: Text("Logout",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            onPressed: () {
                              logout(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  )));
        });
  }
}

// the logout function
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
}
