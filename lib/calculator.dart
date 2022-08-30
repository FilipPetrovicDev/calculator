import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget numButton(String btnText, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () => {calculate(btnText)},
      child: Text(
        btnText,
        style: TextStyle(fontSize: 25, color: txtColor),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(70, 70),
        shape: CircleBorder(),
        primary: btnColor,
      ),
    );
  }

  Widget eqButton(String eqText, Color eqColor, Color eqtextColor) {
    return ElevatedButton(
      onPressed: () => {calculate(eqText)},
      child: Text(
        eqText,
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(150, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: eqColor,
      ),
    );
  }

  Widget delButton(String delText, Color delColor, Color delTextColor) {
    return ElevatedButton(
      onPressed: () {
        calculate(delText);
      },
      child: Icon(Icons.backspace_outlined),
      // child: Text(
      //   delText,
      //   style: TextStyle(fontSize: 20, color: Colors.white),

      style: ElevatedButton.styleFrom(
        fixedSize: Size(70, 70),
        shape: CircleBorder(),
        primary: delColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 196, 196),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Calculator", style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 198, 196, 196),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 80),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numButton("C", Colors.orangeAccent, Colors.white),
                  numButton("⌫", Colors.orangeAccent, Colors.white),
                  numButton("+/-", Colors.orangeAccent, Colors.white),
                  numButton("/", Colors.orangeAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numButton("7", Colors.grey, Colors.white),
                  numButton("8", Colors.grey, Colors.white),
                  numButton("9", Colors.grey, Colors.white),
                  numButton("x", Colors.orangeAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numButton("4", Colors.grey, Colors.white),
                  numButton("5", Colors.grey, Colors.white),
                  numButton("6", Colors.grey, Colors.white),
                  numButton("-", Colors.orangeAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numButton("1", Colors.grey, Colors.white),
                  numButton("2", Colors.grey, Colors.white),
                  numButton("3", Colors.grey, Colors.white),
                  numButton("+", Colors.orangeAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                numButton("0", Colors.grey, Colors.white),
                numButton(".", Colors.grey, Colors.white),
                eqButton("=", Colors.orange, Colors.white),
              ]),
              SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }

  // logic
  double firstNumber = 0;
  double secondNumber = 0;
  dynamic finalResult = "";
  dynamic result = "";
  dynamic text = "0";
  dynamic operation = "";
  dynamic preOperation = "";

  void calculate(String btnText) {
    if (btnText == "C") {
      result = "";
      text = "0";
      firstNumber = 0;
      secondNumber = 0;
      finalResult = "0";
      operation = "";
      preOperation = "";
    } else if (operation == "=" && btnText == "=") {
      if (preOperation == "+") {
        finalResult = add();
      } else if (preOperation == "-") {
        finalResult = sub();
      } else if (preOperation == "x") {
        finalResult = mul();
      } else if (preOperation == "/") {
        finalResult = div();
      }
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "/" ||
        btnText == "=") {
      if (firstNumber == 0) {
        firstNumber = double.parse(result);
      } else {
        secondNumber = double.parse(result);
      }

      if (operation == "+") {
        finalResult = add();
      } else if (operation == "-") {
        finalResult = sub();
      } else if (operation == "x") {
        finalResult = mul();
      } else if (operation == "/") {
        finalResult = div();
      }
      preOperation = operation;
      operation = btnText;
      result = "";
    } else if (btnText == "⌫") {
      if (result != null && result.length > 0) {
        result = result.substring(0, text.length - 1);
        finalResult = doesContainDecimal(result);
      }
      finalResult = result;
    } else if (btnText == "+/-") {
      result.toString().startsWith("-")
          ? result = result.toString().substring(1)
          : result = "-" + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (firstNumber + secondNumber).toString();
    firstNumber = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (firstNumber - secondNumber).toString();
    firstNumber = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (firstNumber * secondNumber).toString();
    firstNumber = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (firstNumber / secondNumber).toStringAsFixed(2);
    firstNumber = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains(".")) {
      List<String> splitDecimal = result.toString().split(".");
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
