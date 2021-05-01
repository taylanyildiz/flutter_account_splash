import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen.dart';

/// [Route] change page animation
Route createRoute(Widget child) => PageRouteBuilder(
      transitionDuration: Duration(seconds: 4),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = animation.drive(Tween(begin: 0.0, end: 1.0).chain(
            CurveTween(curve: Interval(0.0, 0.6, curve: Curves.linear))));

        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (context, child) => ShaderMask(
            shaderCallback: (rect) => RadialGradient(
              radius: tween.value * 2.5,
              colors: [
                Colors.white,
                Colors.white,
                Colors.transparent,
                Colors.transparent,
              ],
              center: FractionalOffset(0.1, 0.0),
              stops: [0.0, 1.0, 0.0, 0.0],
            ).createShader(rect),
            child: child,
          ),
        );
      },
    );

class SplashScreen extends StatefulWidget {
  final String? title;

  const SplashScreen({
    Key? key,
    this.title,
  }) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controllerTrans;
  late AnimationController controllerFinal;
  late Animation<double> logoPaintAnim;
  late Animation<double> logoTrans;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controllerFinal = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controllerTrans = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    logoPaintAnim = CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 1.0, curve: Curves.linear),
    );

    controller.forward().whenComplete(() => controllerTrans
        .forward()
        .whenComplete(() =>
            controllerFinal.forward().whenComplete(() => checkAccount())));
    logoTrans = Tween<double>(begin: 0.0, end: .2).animate(
      CurvedAnimation(
        parent: controllerTrans,
        curve: Curves.linear,
      ),
    );
  }

  Future checkAccount() async {
    var sp = await SharedPreferences.getInstance();
    String mail = sp.getString('mail') ?? '';
    String pass = sp.getString('password') ?? '';
    if (mail.isNotEmpty && pass.isNotEmpty)
      Navigator.push(context, createRoute(HomeScreen()));
    else
      Navigator.push(context, createRoute(WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controllerFinal,
              builder: (context, index) => Transform.scale(
                scale: controllerFinal.drive(Tween(begin: 1.0, end: 0.0)).value,
                child: Stack(
                  children: [
                    LogoAnim(
                      animation: logoPaintAnim,
                      width: 100.0,
                      height: 100.0,
                    ),
                    AnimatedBuilder(
                      animation: logoTrans,
                      builder: (context, child) => Transform.rotate(
                        angle: logoTrans.value,
                        alignment: Alignment.bottomRight,
                        child: LogoAnim(
                          animation: logoPaintAnim,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
