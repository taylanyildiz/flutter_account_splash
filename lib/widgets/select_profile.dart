import 'package:flutter/material.dart';

class SelectProfile extends StatefulWidget {
  @override
  _SelectProfileState createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40.0,
      top: 100.0,
      child: Row(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.orange,
                    size: 40.0,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () => print('select photo'),
                      child: Icon(
                        Icons.add,
                        size: 20.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            'CutFinger',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
