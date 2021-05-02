import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/widgets/widget.dart';

/// [AccountPage]
// ignore: must_be_immutable
class AccountPage extends StatelessWidget {
  AccountPage({
    Key? key,
    required this.controller,
    required this.onPageChange,
    required this.formKeyRegister,
    required this.formKeyLog,
    required this.onBackPageChange,
    required this.textController,
  })   : assert(formKeyLog != null),
        super(key: key);

  final PageController controller;
  final Function(int) onPageChange;
  final Function onBackPageChange;
  final formKeyLog;
  final formKeyRegister;
  final List textController;

  int currentPage = 0;

  Future<List<Widget>> pages() async {
    final page = <Widget>[
      LoginPage(
        key: UniqueKey(),
        formKey: formKeyLog,
        controller: [textController[0], textController[1]],
        onPressed: () => _createAccount(),
      ),
      RegisterPage(
        key: UniqueKey(),
        formKey: formKeyRegister,
        controller: [textController[2], textController[3], textController[4]],
      ),
    ];
    return page;
  }

  void _createAccount() {
    controller.jumpToPage(1);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 5.0,
      child: Container(
        width: size.width,
        height: 400.0,
        child: Stack(
          children: [
            FutureBuilder<List<Widget>>(
              future: pages(),
              builder: (context, constraint) {
                if (constraint.hasData) {
                  List pages = constraint.data!;
                  return PageView.builder(
                    controller: controller,
                    //physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (page) => {
                      currentPage = page,
                      onPageChange.call(page),
                    },
                    itemCount: pages.length,
                    itemBuilder: (context, index) => pages[index],
                  );
                } else {
                  return Container();
                }
              },
            ),
            Positioned(
              left: 5.0,
              top: 5.0,
              child: Container(
                padding: EdgeInsets.only(left: 2.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  onPressed: () => onBackPageChange.call(),
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
