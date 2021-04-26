import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/video_page.dart';
import 'package:flutter_app/video.dart';
import 'package:flutter_app/videos/video_pojo.dart';
import 'package:flutter_app/widgets/custom_video_player12.dart';
import 'package:flutter_app/widgets/show_up.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:visibility_detector/visibility_detector.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => new _DashboardState();
}

var now = new DateTime.now();
var monthf = new DateFormat('MMMM');
var yearf = new DateFormat('y');
var dayf = new DateFormat('d');
var weekdayf = new DateFormat('EEEE');
String month = monthf.format(now);
String year = yearf.format(now);
String day2 = dayf.format(now);
String weekday = weekdayf.format(now);
String formattedTime = DateFormat.H().format(now);

Future<dynamic> myBackgroundMsg(Map<String,dynamic>message){
  return _DashboardState().showMessage(message);
}
class _DashboardState extends State<Dashboard> with WidgetsBindingObserver{
  bool isHomeDataLoading = false;
  VideoPlayerController _controller;

  setLoading(bool loading) {
    setState(() {
      isHomeDataLoading = loading;
    });
  }

  Future showMessage(Map<String, dynamic> message) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : from back"),
        );
      },
    );
  }

  fetch() {
    setLoading(true);
  }

  String first_name, last_name, image,user_type;

  String greeting = "";
  bool visible = false;
  TargetPlatform _platform;
  //FlickManager flickManager;
  String welcome_video_file = "",
      headline_title,
      video_locality,
      reporter_name,
      reporter_image,
      posted_date,
      posted_time;
  static int _listLimit ;
  List<Orders> students = new List();

  List names = new List();
  ScrollController scrollController = new ScrollController();

  String addVideoPermission;

  //  9999771574   test number for app
  //  sitaramm

  bool isLoading = false;

  //call on scroll
  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  VideoPojo pojo;
  Future<void> getQuotes(String type, String text) async {
    access_token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC93ZXdhdGNoLmluXC93ZXdhdGNoLWxpdmVcL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjE4NzMwNzYwLCJleHAiOjE2MjM5MTQ3NjAsIm5iZiI6MTYxODczMDc2MCwianRpIjoiV1U4RlhEcUk2aU9CVTNWWiIsInN1YiI6MjQ4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.9w4a9BWNqeNlYIN61UPFxdaku-I310DUPTqGuC782tE"; // dummy test
    String login_url =
        "https://wewatch.in/wewatch-live/api/v1/video-listing"+"?page="+type+"&city=Delhi";//+"&pincode="+pinCode+"&state="+stateName;//+pinCode;
    var response = await http.post(login_url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    });


    // setState(() {
    //   visible=true;
    //   //pojo = null;
    // });
    print("url="+login_url);
    try {
      if (response.statusCode == 200) {
        pojo= VideoPojo.fromJson(jsonDecode(response.body));
        print("length==> "+pojo.data.orders.length.toString());
        if(pojo!=null && pojo.data.orders.length>0) {
          students.addAll(pojo.data.orders);
          if([null,""].contains(welcome_video_file)){
            welcome_video_file=pojo.data.welcomeVideo;
          }
        }
      } else {
        //throw Exception(MESSAGES.INTERNET_ERROR);

      }
    } catch (e) {
      setState(() {
        moreDataLoading = false;
      });
      //throw Exception(e);
      print("problem");
    }
    finally{
      getQuoteCalled=false;
      setState(() {
        visible=false;
      });
    }


//    prefs.setString('main_token',body['token'] );
//    print(body['token']);
  }

  bool moreDataLoading=false;
  String first = ' ';
  String second = 'Guest';
  bool apiCalled=true;
  @override
  void initState() {
    moreDataLoading=true;
    _listLimit = 1;
    getQuotes(_listLimit.toString(), "");
    scrollController.addListener(() {
      print("called ");
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _listLimit = _listLimit + 1;
        setState(() {
          moreDataLoading=true;
        });
        if(apiCalled) {
          apiCalled=false;
          getQuotes(_listLimit.toString(), "");
        }
      }else{

      }
    });
    super.initState();
  }


  String access_token;
  String pinCode="";
  void fetchfive() {
    getQuotes(_listLimit.toString(), "");
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    // flickManager.flickControlManager.pause();
    // flickManager.dispose();
    WidgetsBinding.instance.removeObserver(this);

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused ||state == AppLifecycleState.detached) {
      //do your stuff
      //  flickManager.flickControlManager.pause();
    }
  }
  DateTime currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool getQuoteCalled=false;
  Future<bool> willPop()async{
    //flickManager.flickControlManager.pause();
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // Fluttertoast.showToast(msg: "exit want");

      return Future.value(false);
    }
    print("here");
    return Future.value(true);
  }
  int delayTime=1000;
  @override
  Widget build(BuildContext context) {
    int a = int.parse(formattedTime);
    print(a);
    if (a >= 5 && a < 12) {
      greeting = "Good Morning";
    } else if (a >= 12 && a < 17) {
      greeting = "Good Afternoon";
    } else if (a >= 17 && a < 20) {
      greeting = "Good Evening";
    } else {
      greeting = "Good Night";
    }
    Timer _timer;
    _AnimatedFlutterLogoState() {
      _timer = new Timer(const Duration(milliseconds: 1000), () {
        setState(() {
          first = first_name;
        });
      });
    }
    return WillPopScope(

      onWillPop: ()=> willPop(),
      child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(Icons.switch_video,color: Colors.white,),
              onPressed: () {
                if(!["",null].contains(addVideoPermission) && addVideoPermission.trim().compareTo("yes")==0){
                  print("image"+image);
                  //setState(() {});
                }else {
                  //UtilityClass.showMsg("soorry");
                  showPermissionDialog();
                }

              }),

          body:
          RefreshIndicator(
            backgroundColor: Colors.blue,
            color: Colors.white,
            strokeWidth: 3,
            onRefresh: () async{
              try {
                setState(() {
                  students.clear();
                });
                _listLimit=1;
                delayTime=1000;
                getQuotes(_listLimit.toString(), "");

              }catch(ex){}
            },
            child: Container(
              height: getScreenSize(context: context).height,
              width: getScreenSize(context: context).width,
              child: Stack(
                children: [
                  Container(
                    child: ListView(
                      controller: scrollController,
                      children: <Widget>[
                        ShowUp(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: (![
                                              "",
                                              null,
                                              false,
                                              0,
                                            ].contains(image))
                                                ? NetworkImage(
                                              image,
                                            )
                                                :
                                            NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsJ774VL7RjYJGKgiFM2E1DmvLT3NeldlBWA&usqp=CAU',
                                            )
                                            // AssetImage(
                                            //   "assets/images/logo_splash.png",
                                            // ),
                                          ))),
                                ),
                                FutureBuilder(
                                  future: Future.delayed(Duration(seconds: 3)),
                                  builder: (c, s) => s.connectionState ==
                                      ConnectionState.done
                                      ? first_name != null
                                      ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: Align(
                                              child: new Text(
                                                "Hi! " + first_name,

                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
//                                    textDirection:
//                                    TextDirection.ltr,
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 5.0, 0.0, 0.0),
                                            child: Align(
                                              child: new Text(
                                                day2 + " " + month + " " + year,
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.left,
//                                    textDirection:
//                                    TextDirection.LTR,
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Align(
                                                  child: new Text(
                                                    (![
                                                      "",
                                                      null,
                                                      false,
                                                      0,
                                                    ].contains(greeting))
                                                        ? greeting
                                                        : "Good Evening",
                                                    style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ),
                                                    textAlign: TextAlign.left,
//                                        textDirection:
//                                        TextDirection.ltr,
                                                  ),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    10.0, 5.0, 0.0, 0.0),
                                                child: Align(
                                                  child: new Text(
                                                    '',
                                                    style: TextStyle(
                                                      color: Color(0xff00adef),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ),
                                                    textAlign: TextAlign.left,
//                                        textDirection:
//                                        TextDirection.ltr,
                                                  ),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                      : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: Align(
                                              child: new Text(
                                                "Hi! Guest",

                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
//                                    textDirection:
//                                    TextDirection.ltr,
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 5.0, 0.0, 0.0),
                                            child: Align(
                                              child: new Text(
                                                day2 + " " + month + " " + year,
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.left,
//                                    textDirection:
//                                    TextDirection.LTR,
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Align(
                                                  child: new Text(
                                                    (![
                                                      "",
                                                      null,
                                                      false,
                                                      0,
                                                    ].contains(greeting))
                                                        ? greeting
                                                        : "Good Evening",
                                                    style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ),
                                                    textAlign: TextAlign.left,
//                                        textDirection:
//                                        TextDirection.ltr,
                                                  ),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    10.0, 5.0, 0.0, 0.0),
                                                child: Align(
                                                  child: new Text(
                                                    '',
                                                    style: TextStyle(
                                                      color: Color(0xff00adef),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ),
                                                    textAlign: TextAlign.left,
//                                        textDirection:
//                                        TextDirection.ltr,
                                                  ),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                      : Text(''),
                                ),
                              ],
                            ),
                          ),
                          delay: 100,
                        ),

                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),

//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       GestureDetector(
//                                         onTap: () {
//
//                                         },
//                                         child: Padding(
//                                           padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                           child: Center(
//                                             child: Container(
//                                               height: 50,
//                                               width: 50,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                 BorderRadius.all(Radius.circular(30)),
//
//                                               ),
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding: EdgeInsets.all(0),
//                                                   child: Icon(Icons.play_circle_fill_sharp,size: 50,),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                         const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
//                                         child: Align(
//                                           child: new Text(
//                                             'Latest Videos',
//                                             style: TextStyle(
//                                               color: Color(0xff444b69),
//                                               fontSize: 10,
//                                               letterSpacing: 0,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                           alignment: Alignment.center,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: GestureDetector(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Padding(
//                                           padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                           child: Center(
//                                             child: Container(
//                                               height: 50,
//                                               width: 50,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                 BorderRadius.all(Radius.circular(30)),
// //                                            border: Border.all(
// //                                                                   width: 0,
// //                                                                   color: Colors
// //                                                                       .lightBlue,
// //                                                                   style:
// //                                                                   BorderStyle
// //                                                                       .solid)
//                                               ),
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding: EdgeInsets.all(0),
//                                                   child:
//                                                   Image.asset(
//                                                     "assets/images/social_workers_two.png",
// //                                              height: 150.0,
// //                                              width: 50.0,
//                                                     fit: BoxFit.fill,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               0.0, 5.0, 0.0, 0.0),
//                                           child: Align(
//                                             child: new Text(
//                                               'Social',
//                                               style: TextStyle(
//                                                 color: Color(0xff444b69),
//                                                 fontSize: 10,
//                                                 letterSpacing: 0,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                             alignment: Alignment.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   onTap: () {
//                                   },
//                                 ),
//                               ),
//                               Expanded(
//                                 child: GestureDetector(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Padding(
//                                           padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                           child: Center(
//                                             child: Container(
//                                               height: 50,
//                                               width: 50,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                 BorderRadius.all(Radius.circular(30)),//
//                                               ),
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding: EdgeInsets.all(0),
//                                                   child: Image.asset(
//                                                     "assets/images/jobs_feed_two.png",
// //                                              height: 150.0,
// //                                              width: 50.0,
//                                                     fit: BoxFit.fill,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               0.0, 5.0, 0.0, 0.0),
//                                           child: Align(
//                                             child: new Text(
//                                               'Job Feeds',
//                                               style: TextStyle(
//                                                 color: Color(0xff444b69),
//                                                 fontSize: 10,
//                                                 letterSpacing: 0,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                             alignment: Alignment.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   onTap: () {
//
//                                   },
//                                 ),
//                               ),
//                               Expanded(
//                                 child: GestureDetector(
//                                   child: Padding(
//                                     padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Padding(
//                                           padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                           child: Center(
//                                             child: Container(
//                                               height: 50,
//                                               width: 50,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                 BorderRadius.all(Radius.circular(30)),
//                                               ),
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding: EdgeInsets.all(0),
//                                                   child: Image.asset(
//                                                     "assets/images/empolyee_two.png",
// //                                              height: 150.0,
// //                                              width: 50.0,
//                                                     fit: BoxFit.fill,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               0.0, 5.0, 0.0, 0.0),
//                                           child: Align(
//                                             child: new Text(
//                                               'Employee',
//                                               style: TextStyle(
//                                                 color: Color(0xff444b69),
//                                                 fontSize: 10,
//                                                 letterSpacing: 0,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                             alignment: Alignment.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   onTap: () {
//
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

                        SizedBox(
                          height: 0,
                        ),
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: Center(
                                          child: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: (![
                                                      "",
                                                      null,
                                                      false,
                                                      0,
                                                    ].contains(reporter_image))
                                                        ?
                                                    // AssetImage(
                                                    //   "assets/images/logo_splash.png",
                                                    // )

                                                    NetworkImage(
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsJ774VL7RjYJGKgiFM2E1DmvLT3NeldlBWA&usqp=CAU',
                                                    )
                                                        :
                                                    NetworkImage(
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsJ774VL7RjYJGKgiFM2E1DmvLT3NeldlBWA&usqp=CAU',
                                                    )
                                                    // AssetImage(
                                                    //   "assets/images/logo_splash.png",
                                                    // ),
                                                  ))),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                child: Align(
                                                  child: new Text(
                                                    "We watch ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
//                                              textDirection:
//                                              TextDirection.ltr,
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {},
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                        child: Container(
                                          height: 300,
                                          width: MediaQuery.of(context).size.width,
//                width: 100,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                              child: Container(
                                                  height: 400,
                                                  width: MediaQuery.of(context).size.width,
                                                  child:!["",null].contains(welcome_video_file)?

                                                  // VideoPage(video: Video(
                                                  //     title: "",url: welcome_video_file
                                                  // ))
                                                  AllMediaWidget(path: welcome_video_file,thumbnailForVideo: null,)

                                                      :Container(
                                                    child: Center(child: CircularProgressIndicator()),
                                                    color: Colors.black87,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          elevation: 5,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ),
                        students.length>0?Padding(
                          padding: EdgeInsets.all(0),
                          child: SizedBox(
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                itemCount: students.length,
                                itemBuilder: (BuildContext context, int index){
                                  delayTime+=500;
                                  return VisibilityDetector(
                                    key: Key(index.toString()),
                                    onVisibilityChanged: (VisibilityInfo info) {
                                      if (info.visibleFraction == 1)
                                        setState(() {
                                          // _currentItem = index;
                                          print('curent index: $index');
                                        });
                                    },
                                    child: students[index]!=null?QuotesCell(
                                        students[index],index):Container(),
                                  );
                                },
                              )),
                        ):Container(),


                        moreDataLoading? Center(
                            child: CupertinoActivityIndicator(radius: 16.0,)
                        ):Container()
                      ],
                    ),
                    color: Color(0xfff9f9f9),
                  ),
                  visible?Center(child: _getFullScreenLoader):Container()
                ],
              ),
            ),
          ) ),
    );
  }

  Size getScreenSize({@required BuildContext context}) {
    return MediaQuery.of(context).size;
  }
  StreamController<bool> _loaderStreamController=new StreamController<bool>();
  get _getFullScreenLoader {
    if(!_loaderStreamController.hasListener){
      _loaderStreamController=new StreamController<bool>();
    }
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: getScreenSize(context: this.context).height,
      width: getScreenSize(context: this.context).width,
      child: Center(
        child: new CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
          strokeWidth: 6.0,
        ),
      ),
    );
  }
  void showPermissionDialog() {

  }
}

class QuotesCell extends StatefulWidget {
  int countValue = 0;
  final Orders cellModel;
  final int activeIndex;
  QuotesCell(this.cellModel,this.activeIndex);

  @override
  _QuotesCellState createState() => _QuotesCellState(this.cellModel);
}

class _QuotesCellState extends State<QuotesCell> {
  bool countValue = false, countValue1 = false;
  int doLogin;
  final Orders cellModel;
  _QuotesCellState(this.cellModel);
//  FlickManager flickManager;
  VideoPlayerController _controller;

  Stream<FileResponse> fileStream;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('activeindex here${widget.activeIndex}');
  }
  Future<void >initVideo() async{
    try {
      // flickManager = FlickManager(
      //     videoPlayerController: VideoPlayerController.network(
      //         !["", null].contains(cellModel.video_file)
      //             ? cellModel.video_file
      //             : cellModel.video_file),
      //     autoPlay: false, autoInitialize: true);

    }catch(ex){}
  }

  bool isDislike=false,islike=false;

  @override
  void dispose() {
    // flickManager.flickControlManager.pause();
    // flickManager.dispose();
    //flickManager.flickControlManager.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Center(
                                  child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: (![
                                              "",
                                              null,
                                              false,
                                              0,
                                            ].contains(cellModel
                                                .reporterImage))
                                                ? NetworkImage(
                                              cellModel.reporterImage,
                                            )
                                                : AssetImage(
                                              "assets/images/logo_splash.png",
                                            ),
                                          ))),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: Align(
                                          child: new Text(
                                            (![
                                              "",
                                              null,
                                              false,
                                              0,
                                            ].contains(cellModel.videoTitle))
                                                ? cellModel.videoTitle
                                                : "Video title",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
//                                              textDirection:
//                                              TextDirection.ltr,
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.9,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                child: Align(
                                                  child: new Text(
                                                    (![
                                                      "",
                                                      null,
                                                      false,
                                                      0,
                                                    ].contains(cellModel
                                                        .reporterName))
                                                        ? cellModel
                                                        .reporterName +
                                                        " | "
                                                        : "Video title | ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
//                                              textDirection:
//                                              TextDirection.ltr,
                                                  ),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 0.0, 0.0),
                                                  child: Align(
                                                    child: Container(
                                                      child: new Text(
                                                        (![
                                                          "",
                                                          null,
                                                          false,
                                                          0,
                                                        ].contains(cellModel
                                                            .videoLocality))
                                                            ? cellModel
                                                            .videoLocality +
                                                            ", "
                                                            : "Video title, ",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10.6,
                                                          letterSpacing: 0,
                                                        ),
                                                        textAlign:
                                                        TextAlign.left,
//                                              textDirection:
//                                              TextDirection.ltr,
                                                      ),
                                                    ),
                                                    alignment:
                                                    Alignment.centerLeft,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {

                          },
                          child: Stack(
                            //alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: InkWell(
                                  onTap: (){print(cellModel.videoFile);},
                                  child: Container(
                                      height: 400,
//                width: 100,
                                      // ignore: missing_required_param
                                      child: AllMediaWidget(path:cellModel.videoFile ,thumbnailForVideo: cellModel.videoTitle,
                                        wantPlayerController: true,)
                                      // VideoPage(
                                      //   video: Video(url: cellModel.videoFile,title: "",thumbImage: cellModel.videoThumbImage),
                                      // )

                                    // VisibilityDetector(
                                    //  // key: ObjectKey(flickManager),
                                    //   onVisibilityChanged: (visibility) {
                                    //     try
                                    //     {
                                    //       if (visibility.visibleFraction == 0 && this.mounted) {
                                    //         //flickManager.flickControlManager.pause();
                                    //       } else if (visibility.visibleFraction == 1) {
                                    //         //flickManager.flickControlManager.play();
                                    //       }
                                    //       setState(() {
                                    //
                                    //       });
                                    //     }catch(ex){print(ex);}
                                    //
                                    //   },
                                    //   child: Container(
                                    //     // child: FlickVideoPlayer(
                                    //     //   flickManager: flickManager,
                                    //     //   flickVideoWithControls:
                                    //     //   FlickVideoWithControls(
                                    //     //     controls: FlickPortraitControls(),
                                    //     //   ),
                                    //     //   flickVideoWithControlsFullscreen:
                                    //     //   FlickVideoWithControls(
                                    //     //     controls: FlickLandscapeControls(),
                                    //     //   ),
                                    //     // ),
                                    //   ),
                                    // )



                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       if (doLogin == 1) {
//                                         setState(() {
//                                           // if(countValue){
//                                           //   countValue=false;
//                                           //   countValue1=true;
//                                           // }
//                                           // if (!countValue) {
//                                           countValue = true;
//                                           countValue1 = false;
//                                           //islike=!islike;
//                                           // cellModel.total_likes =
//                                           //     cellModel.total_likes + 1;
//                                           // if (cellModel.total_dislikes > 0) {
//                                           //   cellModel.total_dislikes =
//                                           //       cellModel.total_dislikes - 1;
//                                           // }
//                                           //}
//                                         });
//                                       }
//
//                                       if (doLogin == 0) {}
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Padding(
//                                             padding:
//                                             EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                             child: Center(
//                                               child: Container(
//                                                 height: 15,
//                                                 width: 15,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius: BorderRadius.all(
//                                                       Radius.circular(30)),
// //                                            border: Border.all(
// //                                                                   width: 0,
// //                                                                   color: Colors
// //                                                                       .lightBlue,
// //                                                                   style:
// //                                                                   BorderStyle
// //                                                                       .solid)
//                                                 ),
//                                                 child: Center(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.all(0),
//                                                     child: Image.asset(
//                                                       "assets/images/like_grey.png",
// //                                              height: 150.0,
// //                                              width: 50.0,
//                                                       fit: BoxFit.fill,
//                                                       color: islike && int.parse(cellModel.likesCount) >0
//                                                           ? Color(0xff00adef)
//                                                           : Colors.grey,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 0.0, 0.0, 0.0, 0.0),
//                                             child: Align(
//                                               child: new Text(
//                                                 cellModel.likesCount != 0
//                                                     ? cellModel.likesCount
//                                                     .toString() +
//                                                     ' Like'
//                                                     : '0 Like',
//                                                 style: TextStyle(
//                                                   color: Color(0xff444b69),
//                                                   fontSize: 13,
//                                                   letterSpacing: 0,
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                               alignment: Alignment.center,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )),
//                               Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       if (doLogin == 1) {
//                                         setState(() {
//                                           countValue1 = true;
//                                           countValue = false;
//                                           //saveLike(cellModel.id.toString(), "0");
//                                           isDislike=!isDislike;
//                                         });
//                                       } else {}
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Padding(
//                                             padding:
//                                             EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                             child: Center(
//                                               child: Container(
//                                                 height: 15,
//                                                 width: 15,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius: BorderRadius.all(
//                                                       Radius.circular(30)),
//                                                 ),
//                                                 child: Center(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.all(0),
//                                                     child: Image.asset(
//                                                         "assets/images/dislike_grey.png",
//                                                         fit: BoxFit.fill,
//                                                         color: isDislike
//                                                             ? Color(0xff00adef)
//                                                             : Colors.grey),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.fromLTRB( 0.0, 0.0, 0.0, 0.0),
//                                             child: Align(
//                                               child: new Text(
//                                                 !["", null].contains(cellModel
//                                                     .dislikesCount
//                                                     .toString())
//                                                     ? cellModel.dislikesCount
//                                                     .toString() +
//                                                     ' Dislike'
//                                                     : '0 Dislike',
//                                                 style: TextStyle(
//                                                   color: Color(0xff444b69),
//                                                   fontSize: 13,
//                                                   letterSpacing: 0,
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                               alignment: Alignment.center,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )),
//                               Expanded(
//                                 child: Padding(
//                                   padding:
//                                   const EdgeInsets.fromLTRB(5, 10, 5, 10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding:
//                                         EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                         child: Center(
//                                           child: Container(
//                                             height: 15,
//                                             width: 15,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(30)),
//                                             ),
//                                             child: Center(
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(0),
//                                                 child: Image.asset(
//                                                   "assets/images/comments.png",
// //                                              height: 150.0,
// //                                              width: 50.0,
//                                                   fit: BoxFit.fill,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             0.0, 0.0, 0.0, 0.0),
//                                         child: Align(
//                                           child: new Text(
//                                             !["", null].contains(cellModel
//                                                 .commentCount
//                                                 .toString())
//                                                 ? cellModel.commentCount
//                                                 .toString() +
//                                                 ' Comment'
//                                                 : '0 Comment',
//                                             style: TextStyle(
//                                               color: Color(0xff444b69),
//                                               fontSize: 13,
//                                               letterSpacing: 0,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                           alignment: Alignment.center,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10),
//                                   child: GestureDetector(
//                                     onTap: () {
//
//                                     },
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Padding(
//                                           padding:
//                                           EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                           child: Center(
//                                             child: Container(
//                                               height: 15,
//                                               width: 15,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(30)),
//                                               ),
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding: EdgeInsets.all(0),
//                                                   child: Image.asset(
//                                                     "assets/images/share_grey.png",
// //                                              height: 150.0,
// //                                              width: 50.0,
//                                                     fit: BoxFit.fill,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               0.0, 0.0, 0.0, 0.0),
//                                           child: Align(
//                                             child: new Text(
//                                               'Share',
//                                               style: TextStyle(
//                                                 color: Color(0xff444b69),
//                                                 fontSize: 13,
//                                                 letterSpacing: 0,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                             alignment: Alignment.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
                      ],
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          )),
      onTap: () {

      },
    );
  }
}
