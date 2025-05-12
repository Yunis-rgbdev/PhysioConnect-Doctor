import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 720) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
              Container(
              decoration: BoxDecoration(color: Colors.blue[800]),
              width: screenWidth,
              height: 400,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  'Welcome To',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                  'PhysioConnect',
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 100),
            Container(decoration: BoxDecoration(color: Colors.white), padding: EdgeInsets.all(12), child: Align(alignment: Alignment.center, child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: () {
                    Navigator.pushNamed(context, '/login');
                    },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700], fixedSize: Size(200, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32)))),
                   child: Text('Login', style: TextStyle(color: Colors.white)),
                   ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                    },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700], fixedSize: Size(200, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32)))),
                   child: Text('Signup', style: TextStyle(color: Colors.white)),
                   ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/nonreferregister');
                    },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700], fixedSize: Size(200, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32)))),
                   child: Text('Signup Patient', style: TextStyle(color: Colors.white)),
                   ),
              ],
            )),)
          ],
        
        ),
      );
    } else {
      return Container();
    }
    
  }
}