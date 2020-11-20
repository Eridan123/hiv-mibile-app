import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final Widget suffixIcon;
  final bool suffixIconTap;
  final String error;
  final TextInputType keyboardType;
  final Function validator;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    Key key,
    this.controller,
    @required this.hintText,
    this.keyboardType,
    this.obscureText,
    this.enabled,
    this.suffixIcon,
    this.suffixIconTap,
    this.error,
    this.validator,
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: _obscureText ?? false,
      controller: widget.controller,
      enabled: widget.enabled ?? true,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Color(0xffbcbcbc),
          fontFamily: 'Nunito',
        ),
        errorText: widget.error ?? null,
        suffixIcon: (widget.obscureText != null && widget.obscureText)
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    size: 15,
                  ),
                ),
              )
            : widget.suffixIcon,
      ),
      style: TextStyle(
        fontSize: 16,
        color: Color(0xff575757),
        fontFamily: 'Nunito',
      ),
      cursorColor: kColorBlue,
      cursorWidth: 1,
      validator: widget.validator,
    );
  }
}
