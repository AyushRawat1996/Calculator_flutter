import 'package:calculator_app/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String outputText = "0";
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    outputText,
                    style: TextStyle(fontSize: 64),
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            switch (buttons[index]) {
                              case "C":
                                outputText = "0";
                                break;

                              case "DEL":
                                outputText = outputText.length > 1
                                    ? outputText.substring(
                                        0, outputText.length - 1)
                                    : "0";
                                break;

                              case "=":
                              case "ANS":
                                outputText = evaluateExpression();
                                break;

                              default:
                                outputText = outputText == "0"
                                    ? buttons[index]
                                    : outputText + buttons[index];
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    })),
          ),
        )
      ]),
    );
  }

  String evaluateExpression() {
    try {
      String finalExpression = outputText;
      finalExpression = finalExpression.replaceAll("x", "*");

      Parser p = new Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = new ContextModel();
      outputText = exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (e) {
      outputText = "Math Error";
    }

    return outputText;
  }

  isOperator(String buttonText) {
    if (buttonText == "+" ||
        buttonText == "x" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "=" ||
        buttonText == "%") {
      return true;
    }
    return false;
  }
}
