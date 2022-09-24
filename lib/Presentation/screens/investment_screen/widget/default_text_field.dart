import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class DefaultTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  int? lines;
  TextInputType textInputType;
  TextEditingController controller = TextEditingController();

   DefaultTextField({
    required this.hintText,
    required this.controller,
    required this.textInputType,
     this.labelText = "",
     required this.prefixIcon,
     this.suffixIcon,
     this.lines = 1,
    Key? key}) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width*0.05,
        vertical: SizeConfig.height * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          style: GoogleFonts.roboto(
            fontSize: SizeConfig.headline4Size,
            color: ColorManager.black,
            ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.almarai(
              fontSize: SizeConfig.headline4Size,
              color: ColorManager.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: ColorManager.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: ColorManager.black,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: ColorManager.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: ColorManager.red,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorStyle: GoogleFonts.roboto(
              fontSize: 13.0,
              color: ColorManager.red,
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
                widget.prefixIcon,
              color: ColorManager.black,
            ),
          ),
          keyboardType: widget.textInputType,
          controller: widget.controller,
          validator: (value){
            if(value!.isEmpty){
              return 'This field must not be empty';
            }
            return null;
          },
        ),
      ),
    );
  }
}
