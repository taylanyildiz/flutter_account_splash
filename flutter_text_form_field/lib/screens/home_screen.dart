import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/widgets/widget.dart';
import 'screen.dart';

/// [Route] change page animation
Future<Route> createRoute(Widget child) async => PageRouteBuilder(
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

class HomeScreen extends StatefulWidget {
  final String? title;

  const HomeScreen({
    Key? key,
    this.title,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
        .whenComplete(
            () => controllerFinal.forward().whenComplete(() => nextPage())));
    logoTrans = Tween<double>(begin: 0.0, end: .2).animate(
      CurvedAnimation(
        parent: controllerTrans,
        curve: Curves.linear,
      ),
    );
  }

  void nextPage() async {
    Navigator.push(context, await createRoute(WelcomeScreen()));
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
