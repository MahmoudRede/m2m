import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';


class DefaultFormField extends StatelessWidget {

  final String hint;
  final bool isPassword;
  final TextInputType textInputType;
  final TextEditingController controller;
  IconData ?suffixIcon;
  Function ?suffixFunction;
  Widget? prefixWidget;
  final String validText;

  DefaultFormField({
    required this.hint,
    required this.controller,
    required this.textInputType,
    this.isPassword=false,
    this.suffixIcon,
    this.suffixFunction,
    this.prefixWidget,
    required this.validText,
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[150],
        hintStyle: GoogleFonts.lato(
          fontSize: 16.0,
          color: Colors.black54,
        ),
        errorStyle: GoogleFonts.roboto(

        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
        ),
        prefixIcon: prefixWidget,
        suffixIcon: IconButton(onPressed: (){suffixFunction!();}, icon: Icon(suffixIcon),),
      ),
      style: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 15,
      ),
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,

      validator: (value){
        if(value!.isEmpty){
          return validText;
        }
        else
        {
          return null;
        }
      },
    );
  }
}