import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    Key? key,
    required this.pages,
    required this.controller,
  }) : super(key: key);
  final List<Widget> pages;
  final PageController controller;

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 100.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: size.width,
        height: 300.0,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (page) => currentPage = page,
              itemCount: pages.length,
              itemBuilder: (context, index) => pages[index],
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
                  onPressed: () => print('back page'),
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
