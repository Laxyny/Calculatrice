// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(Calculatrice());
}

class Calculatrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculatrice",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculatrice(),
    );
  }
}

class SimpleCalculatrice extends StatefulWidget {
  @override
  State<SimpleCalculatrice> createState() => _SimpleCalculatriceState();
}

class _SimpleCalculatriceState extends State<SimpleCalculatrice> {
  String equation = "0";
  String resultat = "0";
  String expression = "0";

  // ignore: non_constant_identifier_names
  ButtonPressed(String textBoutton) {
    // ignore: avoid_print
    print(textBoutton);
    HapticFeedback.vibrate();

    setState(() {
      if (textBoutton == "C") {
        equation = "0";
        resultat = "0";
      } else if (textBoutton == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) {
          equation = "0";
        }
      } else if (textBoutton == "=") {
        expression = equation;
        expression = expression.replaceAll("÷", "/");
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll(",", ".");

        resultat = resultat.replaceAll(".", ",");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          resultat = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          resultat = "Erreur de syntaxe";
          // ignore: avoid_print
          print(e);
        }
      } else {
        if (equation == "0") {
          equation = textBoutton;
        } else {
          equation = equation + textBoutton;
        }
      }

      if (equation ==
          "1" +
              "2" +
              "3" +
              "4" +
              "5" +
              "6" +
              "7" +
              "8" +
              "9" +
              "00" +
              "0" +
              "2004") {
        // ignore: avoid_print
        print("Easter Egg");
        Alert(context: context, title: "INFORMATION", desc: "Fuck Rossissi !")
            .show();
      }
    });
  }

  // ignore: non_constant_identifier_names
  Widget calculatriceBoutton(
      String textBoutton, Color couleurText, Color couleurBoutton) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: couleurBoutton,
      child: MaterialButton(
        onPressed: () => ButtonPressed(textBoutton),
        padding: const EdgeInsets.all(16),
        child: Text(
          textBoutton,
          style: TextStyle(
            color: couleurText,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //title: const Text("Calculatrice"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(
              equation,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Container(
            color: Colors.black,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
            child: Text(
              resultat,
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
          const Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                //color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: Table(
                  border:
                      TableBorder.symmetric(inside: const BorderSide(width: 1)),
                  children: [
                    TableRow(children: [
                      calculatriceBoutton(
                          "C", Colors.redAccent, Colors.grey.shade900),
                      calculatriceBoutton(
                          "⌫", Colors.white, Colors.grey.shade900),
                      calculatriceBoutton(
                          "%", Colors.white, Colors.grey.shade900),
                      calculatriceBoutton(
                          "÷", Colors.white, Colors.grey.shade900),
                    ]),
                    TableRow(children: [
                      calculatriceBoutton(
                          "1", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "2", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "3", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "x", Colors.white, Colors.grey.shade900),
                    ]),
                    TableRow(children: [
                      calculatriceBoutton(
                          "4", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "5", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "6", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "-", Colors.white, Colors.grey.shade900),
                    ]),
                    TableRow(children: [
                      calculatriceBoutton(
                          "7", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "8", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "9", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "+", Colors.white, Colors.grey.shade900),
                    ]),
                    TableRow(children: [
                      calculatriceBoutton(
                          "00", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "0", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          ",", Colors.white, Colors.grey.shade800),
                      calculatriceBoutton(
                          "=", Colors.green, Colors.grey.shade900),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
