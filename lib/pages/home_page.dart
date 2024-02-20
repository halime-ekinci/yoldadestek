import 'package:flutter/material.dart';
import 'other_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MySizedBox extends StatelessWidget {
  const MySizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.032,
    );
  }
}

class MyButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: /*180*/ MediaQuery.of(context).size.width * 0.46,
        height: /*54*/ MediaQuery.of(context).size.height * 0.066,
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.green : const Color(0xfffcfcfc),
          borderRadius: BorderRadius.circular(50.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

makingPhoneCall(BuildContext context) async {
  var url = Uri.parse("tel:112");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = false;
  String selectedButton = '';

  void _handlePressed(String buttonText) {
    setState(() {
      selectedButton = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/backgroundd.png'), fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.030,
              ),

              //üst kısım
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //sol üst
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          onPressed: () {
                            _handlePressed('Organize Suç');
                          },
                          text: 'Organize Suç',
                          isSelected: selectedButton == 'Organize Suç',
                        ),
                        const MySizedBox(),
                        MyButton(
                          onPressed: () {
                            _handlePressed('Kaçırılma/Esir Alma');
                          },
                          text: 'Kaçırılma/Esir Alma',
                          isSelected: selectedButton == 'Kaçırılma/Esir Alma',
                        ),
                        const MySizedBox(),
                        MyButton(
                          onPressed: () {
                            _handlePressed('Cinayet/Yaralama');
                          },
                          text: 'Cinayet/Yaralama',
                          isSelected: selectedButton == 'Cinayet/Yaralama',
                        ),
                      ],
                    ),
                    //sağ üst
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          onPressed: () {
                            _handlePressed("Trafik Kazası");
                          },
                          text: 'Trafik Kazası',
                          isSelected: selectedButton == 'Trafik Kazası',
                        ),
                        const MySizedBox(),
                        MyButton(
                          onPressed: () {
                            _handlePressed("Aile İçi Şiddet");
                          },
                          isSelected: selectedButton == "Aile İçi Şiddet",
                          text: 'Aile İçi Şiddet',
                        ),
                        const MySizedBox(),
                        MyButton(
                          onPressed: () {
                            _handlePressed("İstismar");
                          },
                          isSelected: selectedButton == "İstismar",
                          text: 'İstismar',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {
                    makingPhoneCall(context);
                    setState(() {
                      isPressed = !isPressed;
                    });
                  },
                  child: Center(
                    child: Image.asset(
                      isPressed ? 'assets/acil_yardim_yesil.png' : 'assets/acil_yardimm.png',
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                ),
              ),

              //alt kısımlar
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //sol alt
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          text: "İntihar",
                          onPressed: () {
                            _handlePressed("İntihar");
                          },
                          isSelected: selectedButton == "İntihar",
                        ),
                        const MySizedBox(),
                        MyButton(
                          text: "Boğulma",
                          onPressed: () {
                            _handlePressed("Boğulma");
                          },
                          isSelected: selectedButton == "Boğulma",
                        ),
                        const MySizedBox(),
                        MyButton(
                          text: 'Kalp Hastalıkları',
                          onPressed: () {
                            _handlePressed("Kalp Hastalıkları");
                          },
                          isSelected: selectedButton == "Kalp Hastalıkları",
                        ),
                      ],
                    ),
                    //sağ alt
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            text: 'Zehirlenme',
                            onPressed: () {
                              _handlePressed("Zehirlenme");
                            },
                            isSelected: selectedButton == "Zehirlenme",
                          ),
                          const MySizedBox(),
                          MyButton(
                            text: 'Madde Bağımlılığı',
                            onPressed: () {
                              _handlePressed("Madde Bağımlılığı");
                            },
                            isSelected: selectedButton == "Madde Bağımlılığı",
                          ),
                          const MySizedBox(),
                          MyButton(
                            isSelected: selectedButton == "Diğer",
                            text: 'Diğer',
                            onPressed: () {
                              _handlePressed("Diğer");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OtherPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
