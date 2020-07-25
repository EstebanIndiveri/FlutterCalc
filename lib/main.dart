import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main(){
  runApp(Calculator());
}
class Calculator extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(), 
    );
  }
}

  class SimpleCalculator extends StatefulWidget{
    @override
    _SimpleCalculatorState createState()=>_SimpleCalculatorState();
  }
  class _SimpleCalculatorState extends State<SimpleCalculator>{

    String equation='0';
    String result='0';
    String expression='';
    double equationFontSize=38.0;
    double resultFonSize=48.0;
    buttonPressed(String buttonText){
      setState(() {
        if(buttonText=='C'){
          equation='0';
          result='0';
          equationFontSize=38.0;
          resultFonSize=48.0;
        }else if(buttonText=='⌫'){
          equationFontSize=48.0;
          resultFonSize=38.0;
          equation=equation.substring(0,equation.length - 1);
          if(equation==''){
            equation='0';
          }
        }else if(buttonText=='='){
          equationFontSize=38.0;
          resultFonSize=48.0;
          expression=equation;
          expression=expression.replaceAll('×','*');
          expression=expression.replaceAll('÷','/');

          try{
            Parser p = new Parser();
            Expression exp=p.parse(expression);
            ContextModel cm=ContextModel();
            result='${exp.evaluate(EvaluationType.REAL,cm)}';
          }catch(e){
            result='Error';
          }

        }else{
          equationFontSize=48.0;
          resultFonSize=38.0;
          if(equation=='0'){
            equation=buttonText;
          }else{
            equation=equation + buttonText;
          }
        }
      });
    }

    Widget buildBotton(String buttonText,double bottonHeight,Color bottonColor){
      return Container(
                        height: MediaQuery.of(context).size.height * 0.1 * bottonHeight,
                        color: bottonColor,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(
                              color:Colors.white,
                              width: 1,
                              style: BorderStyle.solid
                              )
                          ),
                          padding: EdgeInsets.all(16),
                          onPressed: ()=>buttonPressed(buttonText),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.normal,
                              color:Colors.white
                            ),
                          ),
                        ),
                      );
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('Simple Calculator'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(equation,style:TextStyle(fontSize: equationFontSize)),
            ),
             Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(result,style:TextStyle(fontSize: resultFonSize)),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildBotton('C',1,Colors.redAccent),
                          buildBotton('⌫',1,Colors.blue),
                          buildBotton('÷',1,Colors.blue),
                        ]
                      ),
                        TableRow(
                        children: [
                          buildBotton('7',1,Colors.black54),
                          buildBotton('8',1,Colors.black54),
                          buildBotton('9',1,Colors.black54),
                        ]
                      ),
                      TableRow(
                        children: [
                          buildBotton('4',1,Colors.black54),
                          buildBotton('5',1,Colors.black54),
                          buildBotton('6',1,Colors.black54),
                        ]
                      ),
                      TableRow(
                        children: [
                          buildBotton('1',1,Colors.black54),
                          buildBotton('2',1,Colors.black54),
                          buildBotton('3',1,Colors.black54),
                        ]
                      ),
                      TableRow(
                        children: [
                          buildBotton('.',1,Colors.black54),
                          buildBotton('0',1,Colors.black54),
                          buildBotton('00',1,Colors.black54),
                        ]
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildBotton('×',1,Colors.blue),
                        ]
                      ),
                      TableRow(
                        children: [
                          buildBotton('-',1,Colors.blue),
                        ]
                      ),
                      TableRow(
                        children: [
                          buildBotton('+',1,Colors.blue),
                        ]
                      ),
                      TableRow(
                        children: [
                          buildBotton('=',2,Colors.blue),
                        ]
                      ),
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
