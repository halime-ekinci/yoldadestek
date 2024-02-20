import 'package:flutter/material.dart';
import 'package:yoldadestek/pages/home_page.dart';

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundd.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/logo_beyaz_trs.png", height: screenHeight * 0.30,),
                  SizedBox(height: screenHeight * 0.020),
                  Text(
                    'DİĞER ACİL YARDIM SEBEBİ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.027),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.335,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.055),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.055),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          makingPhoneCall(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0144, horizontal: screenWidth * 0.027), // 12 ve 24 boyutunu MediaQuery ile ayarladık
                          child: Text(
                            'Gönder',
                            style: TextStyle(fontSize: screenWidth * 0.048),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
