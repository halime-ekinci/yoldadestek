import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_page..dart';
import 'home_page.dart';
import 'my_textfield.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _tcController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _chronicDiseaseController = TextEditingController();
  final _medicationController = TextEditingController();
  final TextEditingController _otpContoller = TextEditingController();
  final _locationController = TextEditingController();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      _getCurrentLocation();
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konum verilerine erişmek için izin gereklidir.'),
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _locationController.text =
    '${_currentPosition?.latitude}, ${_currentPosition?.longitude}';
  }

  Future<void> _saveUserData(String uid) async {
    Map<String, dynamic> userData = {
      'name': _nameController.text,
      'surname': _surnameController.text,
      'phone': _phoneController.text,
      'tc': _tcController.text,
      'birthdate': _birthdateController.text,
      'bloodGroup': _bloodGroupController.text,
      'chronicDisease': _chronicDiseaseController.text,
      'medication': _medicationController.text,
      'latitude': _currentPosition?.latitude,
      'longitude': _currentPosition?.longitude,
    };

    await FirebaseFirestore.instance.collection('users').doc(uid).set(userData);
    _formKey.currentState?.reset();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kayıt başarıyla tamamlandı.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/register.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("HOŞ GELDİNİZ",
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Icon(Icons.info_outline_rounded, color: Colors.red, size: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text("UYGULAMAYI  KULLANABİLMEK İÇİN KONUM BİLGİSİ CİHAZDA AÇIK OLMALIDIR.",
                                style: TextStyle(color: Colors.white, fontSize: 12))),
                      ],
                    ),
                    MyTextField(
                      controller: _nameController,
                      hintText: "İsim",
                      keyboardType: TextInputType.text,
                    ),
                    MyTextField(
                      controller: _surnameController,
                      hintText: "Soyisim",
                      keyboardType: TextInputType.text,
                    ),
                    PhoneTypeField(hintText: "Telefon", controller: _phoneController),
                    /*MyTextField(controller: _phoneController, hintText: "Telefon", keyboardType: TextInputType.phone,),*/
                    MyTextField(
                        controller: _tcController, hintText: "TC Kimlik No", keyboardType: TextInputType.number),
                    MyTextField(
                      controller: _birthdateController,
                      hintText: "Doğum Tarihi",
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          final formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          _birthdateController.text = formattedDate;
                        }
                      },
                    ),
                    BloodTypeDropdown(
                      controller: _bloodGroupController,
                      hintText: 'Kan Grubu',
                    ),
                    MyTextField(
                        controller: _chronicDiseaseController,
                        hintText: 'Kronik Rahatsızlık',
                        validator: (value) {
                          return null;
                        }),
                    MyTextField(
                      controller: _medicationController,
                      hintText: 'Kullandığınız İlaç',
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthService.sentOtp(
                              phone: _phoneController.text,
                              errorStep: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text(
                                      "SMS gönderilirken hata oluştu",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  )),
                              nextStep: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text("SMS Doğrulama"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("6 Haneli Kodu Giriniz"),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Form(
                                                key: _formKey1,
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: _otpContoller,
                                                  decoration: InputDecoration(
                                                      labelText: "Kodu Giriniz",
                                                      border:
                                                          OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
                                                  validator: (value) {
                                                    if (value!.length != 6) return "Geçersiz Kod";
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  if (_formKey1.currentState!.validate()) {
                                                    AuthService.loginWithOtp(otp: _otpContoller.text).then((value) {
                                                      if (value == "Success") {
                                                        _saveUserData(FirebaseAuth.instance.currentUser!.uid);
                                                        Navigator.pop(context);
                                                        Navigator.pushReplacement(context,
                                                            MaterialPageRoute(builder: (context) => const HomePage()));
                                                      } else {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                          content: Text(
                                                            value,
                                                            style: const TextStyle(color: Colors.white),
                                                          ),
                                                          backgroundColor: Colors.red,
                                                        ));
                                                      }
                                                    });
                                                  }
                                                },
                                                child: const Text("Gönder"))
                                          ],
                                        ));
                              });
                        }
                      },
                      child: const Text("Kayıt Ol"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow, foregroundColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
