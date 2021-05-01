import 'package:flutter/material.dart';
import '../widgets/widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

/// PageView.builder have register and login with animation
class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController? _contoller;
  PageController? _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    _contoller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 1),
    );

    _contoller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _contoller!.reverse();
      }
    });
  }

  final _screens = <Widget>[
    _LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AccountPage(pages: _screens, controller: _pageController!),
              TransitionAnim(animation: _contoller!.view),
              SelectProfile(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_contoller!.status != AnimationStatus.reverse) {
            _contoller!.forward();
          }
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

/// [PageView.builder] returns pages
class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.0),
          Form(
            child: Column(
              children: [
                SizedBox(
                  width: size.width * .8,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'e-mail',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  width: size.width * .8,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility_off),
                        onPressed: () => print('visibility'),
                      ),
                      labelText: 'password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'or',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: size.width * .7,
            child: MaterialButton(
              onPressed: () => print(''),
              child: Text('Create Account'),
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ),
        ],
      ),
    );
  }
}
