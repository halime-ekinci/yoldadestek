import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;

  const MyTextField({super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.onTap,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
      child: TextFormField(
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir ${widget.hintText} girin';
              }
              return null;
            },
        style: const TextStyle(color: Color(0xfffcfcfc)),
        controller: widget.controller,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.green),
            ),
            fillColor: Colors.transparent,
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Color(0xfffcfcfc), fontWeight: FontWeight.w300)),
      ),
    );
  }
}

class PhoneTypeField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const PhoneTypeField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
      child: IntlPhoneField(
        style: const TextStyle(
          color: Colors.white,
        ),
        dropdownTextStyle: const TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.green),
          ),
          fillColor: Colors.transparent,
          filled: true,
          counterStyle: const TextStyle(color: Colors.white),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xfffcfcfc), fontWeight: FontWeight.w300),
        ),
        initialCountryCode: 'TR',
        onSaved: (phone) {
          if (phone != null) {
            final formattedPhone = '+${phone.countryCode}${phone.number}';
            controller.text = formattedPhone;
          }
        },
        onChanged: (phone) {
        },
      ),
    );
  }
}

class BloodTypeDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? valid;

  const BloodTypeDropdown({super.key, required this.controller, required this.hintText, this.valid});

  @override
  _BloodTypeDropdownState createState() => _BloodTypeDropdownState();
}

class _BloodTypeDropdownState extends State<BloodTypeDropdown> {
  String? _selectedBloodType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.grey, // Dropdown menü arka plan rengi
          ),
          child: DropdownButtonFormField<String>(
            menuMaxHeight: 200,
            validator: widget.valid ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir ${widget.hintText} girin';
                  }
                  return null;
                },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              fillColor: Colors.transparent,
              filled: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color(0xfffcfcfc), fontWeight: FontWeight.w300),
            ),
            value: _selectedBloodType,
            onChanged: (String? newValue) {
              setState(() {
                _selectedBloodType = newValue;
                widget.controller.text = newValue ?? '';
              });
            },
            items: <String>["0 RH(+)", "0 RH(-)", "A RH(+)", "A RH(-)", "B RH(+)", "B RH(-)", "AB RH(+)", "AB RH(-)"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white), // Seçenek metin rengi
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
