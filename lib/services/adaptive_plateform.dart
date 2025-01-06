import 'dart:io';

import 'package:calories/models/bottom_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AdaptivePlatform {
  /* =============================================
      SCAFFOLD
   ===============================================*/
  static Widget scaffold(
      {required String title,
        required Widget body,
        required Color backgroundColor}) {
    if (Platform.isIOS) {
      return _iOSScaffold(title, body, backgroundColor);
    }
    return _androidScaffold(title, body, backgroundColor);
  }

  static Scaffold _androidScaffold(
      String title, Widget body, Color backgroundColor) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: backgroundColor,
        ),
        body: body);
  }

  static CupertinoPageScaffold _iOSScaffold(
      String title, Widget body, Color backgroundColor) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
      child: body,
    );
  }

  /* =============================================
      TEXT
   ===============================================*/
  static Widget text(String data,
      {Color? color, double? size, TextAlign? align}) {
    TextStyle style = _textStyle(color: color, size: size);
    if (!Platform.isIOS) {
      return _iOSText(data: data, style: style);
    }
    return _androidText(data: data, style: style);
  }

  static Text _androidText(
      {required String data, required TextStyle style, TextAlign? align}) {
    return Text(
      data,
      style: style,
      textAlign: align ?? TextAlign.left,
    );
  }

  static DefaultTextStyle _iOSText(
      {required String data, required TextStyle style, TextAlign? align}) {
    return DefaultTextStyle(
      style: style,
      child: Text(data),
      textAlign: align ?? TextAlign.left,
    );
  }

  //Both Material
  static TextStyle _textStyle({Color? color, double? size}) {
    return TextStyle(
      color: color ?? Colors.black, // La couleur ou bien noir par défaut
      fontSize: size ?? 10,
    );
  }

  /* =============================================
      SWITCH
   ===============================================*/
  static Widget myswitch(
      {required bool value, required ValueChanged<bool> onChanged}) {
    if (!Platform.isIOS) {
      return _IOSSwitch(value: value, onChanged: onChanged);
    }
    return _androidSwitch(value: value, onChanged: onChanged);
  }

  static Switch _androidSwitch(
      {required bool value, required ValueChanged<bool> onChanged}) {
    return Switch(
        activeColor: Colors.blue,
        inactiveTrackColor: Colors.pink,
        value: value,
        onChanged: onChanged);
  }

  static CupertinoSwitch _IOSSwitch(
      {required bool value, required ValueChanged<bool> onChanged}) {
    return CupertinoSwitch(
        activeColor: Colors.blue,
        trackColor: Colors.pink,
        value: value,
        onChanged: onChanged);
  }

  /* =============================================
      BOUTON
   ===============================================*/
  static Widget button(
      {required Widget child,
        required VoidCallback onPressed,
        required Color backgroundColor}) {
    if (!Platform.isIOS) {
      return _iOSButton(
          child: child, onPressed: onPressed, backgroundColor: backgroundColor);
    }
    return _androidRaisedButton(
        child: child, onPressed: onPressed, backgroundColor: backgroundColor);
  }

  static ElevatedButton _androidRaisedButton(
      {required Widget child,
        required VoidCallback onPressed,
        required Color backgroundColor}) {
    return ElevatedButton(
      child: child,
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor)),
    );
  }

  static CupertinoButton _iOSButton(
      {required Widget child,
        required VoidCallback onPressed,
        required Color backgroundColor}) {
    return CupertinoButton(
      child: child,
      onPressed: onPressed,
      color: backgroundColor,
    );
  }

  /* =============================================
      SLIDER
   ===============================================*/
  static Widget slider(
      {required double value,
        required ValueChanged<double> onChanged,
        required Color activeColor,
        required double min,
        required double max}) {
    if (!Platform.isIOS) {
      return _IOSSlider(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          max: max,
          min: min);
    }
    return _androidSlider(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        max: max,
        min: min);
  }

  static Slider _androidSlider(
      {required double value,
        required ValueChanged<double> onChanged,
        required Color activeColor,
        required double min,
        required double max}) {
    return Slider(
      activeColor: activeColor,
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
    );
  }

  static CupertinoSlider _IOSSlider(
      {required double value,
        required ValueChanged<double> onChanged,
        required Color activeColor,
        required double min,
        required double max}) {
    return CupertinoSlider(
      activeColor: activeColor,
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
    );
  }

  /* =============================================
      TEXTFIELD
   ===============================================*/
  static Widget textField({required TextInputType keyboardType, required ValueChanged<String> onChanged, required String placeHolder}){
    if(!Platform.isIOS){
      return _IOSTextField(keyboardType: keyboardType, onChanged: onChanged, placeHolder: placeHolder);
    }
    return _androidTextField(keyboardType: keyboardType, onChanged: onChanged, placeHolder: placeHolder);
  }

  static TextField _androidTextField({required TextInputType keyboardType, required ValueChanged<String> onChanged, required String placeHolder}){
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: new InputDecoration(
          labelText: placeHolder
      ),
    );
  }

  static CupertinoTextField _IOSTextField({required TextInputType keyboardType, required ValueChanged<String> onChanged, required String placeHolder}) {
    return CupertinoTextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      placeholder: placeHolder,
    );
  }
  /* =============================================
      ALERT
   ===============================================*/
  static Future<dynamic> alert(
      {required BuildContext context,
        required String message,
        required String title}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (Platform.isIOS) {
            return _iOSErrorAlert(
              context: context,
              message: message,
              title:title,);
          }
          return _androidErrorAlert(
            context: context,
            message: message,
            title:title,);
        });
  }

  static _androidErrorAlert(
      {required BuildContext context,
        required String message,
        required String title,}) {
    return AlertDialog(
      title: text(title),
      content: text(message),
      actions: [
        TextButton(
          child: text("OK", color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static _iOSErrorAlert(
      {required BuildContext context,
        required String message,
        required String title,}) {
    return CupertinoAlertDialog(
      title: text(title),
      content: text(message),
      actions: [
        CupertinoDialogAction (
          child: text("Ok", color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )

      ],
    );
  }


  /* =============================================
      DIALOGUE
   ===============================================*/
  static Future<dynamic> dialog(
      {required BuildContext context,
        required List<String> messages,
        required String title}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (Platform.isIOS) {
            return _iOSDialog(
              context: context,
              messages: messages,
              title:title,);
          }
          return _androidDialog(
            context: context,
            messages: messages,
            title:title,);
        });
  }

  static _androidDialog(
      {required BuildContext context,
        required List<String> messages,
        required String title}) {
    List<Widget> l = [];
    messages.forEach((element) {
      l.add(text(element));
    });
    l.add(TextButton(
      child: text("OK", color: Colors.red),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ));

    return SimpleDialog(
      title: text(title),
      contentPadding: EdgeInsets.all(5.0),
      children: l,
    );
  }

  static _iOSDialog(
      {required BuildContext context,
        required List<String> messages,
        required String title,}) {

    List<Widget> l = [];
    messages.forEach((element) {
      l.add(text(element));
    });
    return CupertinoAlertDialog(
      title: text(title),
      content: Column(
        children: l,
      ),
      actions: [
        CupertinoDialogAction (
          child: text("Ok", color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )

      ],
    );
  }


  /* =============================================
        DATEPICKER
  ===============================================*/
  static Future<DateTime?> showDate({required BuildContext context}) async{
    if(!Platform.isIOS){
      return _IOSShowDate(context:context);
    }
    return _androidShowDate(context:context);
  }

  static Future<DateTime?> _androidShowDate({required BuildContext context}) async{
    DateTime? datechoisie = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDate: DateTime.now()
    );
    return datechoisie;
  }

  static Future<DateTime?> _IOSShowDate({required BuildContext context}) async{
    DateTime? datechoisie;
    await showModalBottomSheet(
        context: context,
        builder: (contextBottom){
          return CupertinoDatePicker(
            onDateTimeChanged: (DateTime dt) {
              datechoisie = dt;
            },
            initialDateTime:DateTime.now() ,
            maximumYear: DateTime.now().year,
            minimumYear: 1900,
            mode: CupertinoDatePickerMode.date,
          );
        }
    );

    return datechoisie;
  }

  /* =============================================
        BOTTOM SHEET
  ===============================================*/
  static Future<void> showBottom({required BuildContext context,required String title, required List<BottomAction> actions}) async{
    if(!Platform.isIOS){
      return _IOSShowBottom(context:context, title: title, actions: actions);
    }
    return _androidShowBottom(context:context, title: title, actions: actions);
  }

  static Future<void> _androidShowBottom({required BuildContext context,required String title, required List<BottomAction> actions}){
    List<Widget> l = [];
    l.add(text(title));
    actions.forEach((BottomAction action) {
      l.add(
          SimpleDialogOption(
            child: Row(
              children: [
                Icon(action.icon),
                text(action.texte)
              ],
            ),
            onPressed: action.onPressed,
          )
      );
      l.add(Divider());
    });

    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext contextBottom){
          return Column(
            children: l,
          );
        }
    );
  }

  static Future<void> _IOSShowBottom({required BuildContext context,required String title, required List<BottomAction> actions}){
    List<Widget> l = [];
    actions.forEach((BottomAction action) {
      l.add(
          CupertinoActionSheetAction(
            child: Row(
              children: [
                Icon(action.icon),
                text(action.texte)
              ],
            ),
            onPressed: action.onPressed,
          )
      );
    });

    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext contextBottom){
          return CupertinoActionSheet(
            title: text(title),
            actions: l,
          );
        }
    );
  }




}
