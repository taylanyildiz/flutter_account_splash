import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

/// PageView.builder have register and login with animation
class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  final _formKeylogin = GlobalKey<FormState>();
  final _formkeyRegister = GlobalKey<FormState>();
  AnimationController? _contoller;
  PageController? _pageController;
  final mailLog = TextEditingController();
  final passLog = TextEditingController();
  final nameReg = TextEditingController();
  final mailReg = TextEditingController();
  final passReg = TextEditingController();
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

  void _backPageChange() {
    if (currentPage != 0) {
      currentPage -= 1;
      _pageController!.jumpToPage(currentPage);
    }
  }

  Future checkAccount(String m, String p) async {
    var sp = await SharedPreferences.getInstance();
    String mail = sp.getString('mail') ?? '';
    String pass = sp.getString('pass') ?? '';
    if (mail.isNotEmpty && pass.isNotEmpty) {
      if (mail == m && pass == p) {
        print('true');
      } else {
        /// SnackBar
        print('no account found');
      }
    } else {
      /// [SnackBar]
      print('not found');
    }
  }

  Future createAccount(String m, String p, String n) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString('mail', m);
    sp.setString('pass', p);
    sp.setString('name', n);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AccountPage(
                textController: [mailLog, passLog, nameReg, mailReg, passReg],
                controller: _pageController!,
                formKeyLog: _formKeylogin,
                formKeyRegister: _formkeyRegister,
                onPageChange: (page) => currentPage = page,
                onBackPageChange: () => _backPageChange(),
              ),
              TransitionAnim(animation: _contoller!.view),
              SelectProfile(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_contoller!.status != AnimationStatus.reverse) {
            FocusScope.of(context).unfocus();
            if (currentPage == 0) {
              final isCheck = _formKeylogin.currentState!.validate();
              if (isCheck) {
                String mail = mailLog.text;
                String pass = passLog.text;
                checkAccount(mail, pass);
                _contoller!.forward();
              }
            }
            if (currentPage == 1) {
              final isCheck = _formkeyRegister.currentState!.validate();
              if (isCheck) {
                _contoller!.forward();
                var m = mailReg.text;
                var p = passReg.text;
                var n = nameReg.text;
                await createAccount(m, p, n);
                _pageController!.jumpToPage(0);
              }
            }
          }
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
