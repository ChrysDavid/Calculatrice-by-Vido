import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculatrice());
}

class Calculatrice extends StatelessWidget {
  const Calculatrice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculatrice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculatrice(),
    );
  }
}

class SimpleCalculatrice extends StatefulWidget {
  const SimpleCalculatrice({super.key});

  @override
  State<SimpleCalculatrice> createState() => _SimpleCalculatriceState();
}

class _SimpleCalculatriceState extends State<SimpleCalculatrice> {

  String equation = "0";
  String resultat = "0";
  String expression = "0";

  buttonPressed(String txtBouton) {
    print(txtBouton);

    setState(() {

      if(txtBouton == "C"){
        equation = "0";
        resultat = "0";
      }else if(txtBouton == "⌫"){
        equation = equation.substring(0, equation.length-1);
        if(equation.isEmpty){
          equation = "0";
          
        }
      }else if(txtBouton == "="){
        expression = equation;
        //TODO:expression math*
        expression = expression.replaceAll("÷", "/");
        expression = expression.replaceAll("×", "*");

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          resultat = "${exp.evaluate(EvaluationType.REAL, cm)}";
        }catch(e){
          resultat = "Erreur de syntaxe";
          print(e);
        }
      }else{
        if(equation == "0"){
          equation = txtBouton;
        }else{
          equation = equation + txtBouton;
        }
      }
    });
  }

  Widget calculatriceButon(
      String txtBouton, Color Couleurtxt, Color Couleurbtn) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: Couleurbtn,
      child: MaterialButton(
        onPressed: ()=> buttonPressed(txtBouton),
        padding: EdgeInsets.all(16),
        child: Text(
          txtBouton,
          style: TextStyle(color: Couleurtxt, fontSize: 30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculatrice"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 35),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(
              resultat,
              style: TextStyle(fontSize: 35),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        calculatriceButon("C", Colors.redAccent, Colors.white),
                        calculatriceButon("⌫", Colors.blue, Colors.white),
                        calculatriceButon("%", Colors.blue, Colors.white),
                        calculatriceButon("÷", Colors.blue, Colors.white),
                      ],
                    ),
                    
                    TableRow(
                      children: [
                        calculatriceButon("7", Colors.blue, Colors.white),
                        calculatriceButon("8", Colors.blue, Colors.white),
                        calculatriceButon("9", Colors.blue, Colors.white),
                        calculatriceButon("×", Colors.blue, Colors.white),
                      ],
                    ),

                    TableRow(
                      children: [
                        calculatriceButon("4", Colors.blue, Colors.white),
                        calculatriceButon("5", Colors.blue, Colors.white),
                        calculatriceButon("6", Colors.blue, Colors.white),
                        calculatriceButon("-", Colors.blue, Colors.white),
                      ],
                    ),

                    TableRow(
                      children: [
                        calculatriceButon("1", Colors.blue, Colors.white),
                        calculatriceButon("2", Colors.blue, Colors.white),
                        calculatriceButon("3", Colors.blue, Colors.white),
                        calculatriceButon("+", Colors.blue, Colors.white),
                      ],
                    ),

                    TableRow(
                      children: [
                        calculatriceButon(".", Colors.blue, Colors.white),
                        calculatriceButon("0", Colors.blue, Colors.white),
                        calculatriceButon("00", Colors.blue, Colors.white),
                        calculatriceButon("=", Colors.white, Colors.blue),
                      ],
                    ),
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


