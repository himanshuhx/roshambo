import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black45,
              backgroundImage: AssetImage('images/myImage.jpg'),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Made with <❤>',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Ubuntu',
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'by ~ Himanshu',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Ubuntu',
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                Text(
                  'Follow me on',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset('images/instagram.png'),
                ),
                Text(
                  '/ hek_024',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ubuntu',
                    color: Colors.orange,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
