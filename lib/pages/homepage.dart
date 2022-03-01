import 'package:calculator_app/pages/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userinput ='';
  var answer ='';
  final List<String> _button= [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator App',
          style: TextStyle(fontSize: 25, color: Colors.yellowAccent),
        ),
      ),
      backgroundColor: Color(0xffa7c7fa),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Container(
                  color: Color(0xff6278e3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userinput,
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),
                        ),

                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black87),
                        ),

                      )

                    ],

                  ),

                ),
            ),
            SizedBox(height: 5,),
            Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: _button.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4
                  ),
                  itemBuilder: (BuildContext context ,int index){
                  // clear button
                  if(index==0){
                    return MyButton(
                      buttonText: _button[index],
                      color:Colors.blue[50],
                      textcolor:Colors.black,
                      buttontap: (){
                        setState(() {
                          userinput='';
                          answer='0';
                        });
                      },
                    );
                  }
                  //+/- buttons

                  else if(index==1){
                    return MyButton(
                      buttonText: _button[index],
                    color: Colors.blue[50],
                      textcolor:Colors.black,
                    );

                  }
                  // % buttons

                  else if(index==2){
                    return MyButton(buttonText: _button[index],
                    color: Colors.blue[50],
                      textcolor: Colors.black,
                      buttontap: (){
                     setState(() {
                       userinput+=_button[index];
                     });

                      },
                    );
                  }
                  // delete Button
                    else if(index==3){
                      return MyButton(buttonText: _button[index],
                      color: Colors.blue[50],
                        textcolor: Colors.black,
                        buttontap: (){
                        setState(() {
                          userinput =
                              userinput.substring(0, userinput.length - 1);
                        });
                        },
                      );
                  }

                    // equeal button
                    else if(index==18){
                      return MyButton(buttonText: _button[index],
                      buttontap:(){
                        setState(() {
                          equalPressed();

                        });
                      },
                        color: Colors.orange[700],
                        textcolor: Colors.white,

                      );
                  }
                    // outher button

                    else{
                      return MyButton(
                        buttontap: (){
                          setState(() {
                            userinput+=_button[index];
                          });

                        },
                        buttonText: _button[index],
                        color:isOperator(_button[index])?
                        Colors.blueAccent:
                            Colors.white
                        ,
                        textcolor: isOperator(_button[index])?
                            Colors.white:
                            Colors.blueAccent
                      ,


                      );
                  }

                  }
                  ),
            ),

            )



          ],
        ),
      ),
    );
  }

  bool isOperator(String x){
    if(x=='/'||x=='x'||x=='-' || x=='+' || x == '='){
      return true;
    }
    return false;
  }

// function in
  void equalPressed(){

    String finaluserinput=userinput;
    finaluserinput=userinput.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp =p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer=eval.toString();
  }

}

