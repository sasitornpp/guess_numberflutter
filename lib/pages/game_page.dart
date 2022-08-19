import 'package:flutter/material.dart';
import 'package:guess_numberflutter/game.dart';

class GamePage extends StatefulWidget{
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _controller = TextEditingController();
  final _game = Game();

  //state variable
  var _feedbackText = '';
  var _showTestButton = false;

  //override
  void handleClickGuess(){ // เมธอด
    setState((){
      _showTestButton = !_showTestButton;
    });

    print('Button clicked!');
    print(_controller.text); //โชว์ในหน้ารัน
    var guess = int.tryParse(_controller.text);
    if(guess == null){
      //แจ้ง error
      print('Input ERROR');

      setState((){
        _feedbackText = 'Input ERROR, please try again';
      });

    }else{
      var result = _game.doGuess(guess);
      if(result == Result.tooHigh){
        //ทายมากไป
        print('Too High');
        setState((){
          _feedbackText = 'Too High, please try again';
        });
      }else if(result == Result.tooLow){
       //ทายน้อยไป
        print('Too Low');
        setState((){
          _feedbackText = 'Too Low, please try again';
        });
      }else{
        //ทายถูก
        print('Correct');
        setState((){
          _feedbackText = 'Good job!';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold( //กำหนดพื้นหลังมาแล้ว ลิ้งค์มาแล้ว
      appBar: AppBar(
        title: Text('Guess The Number'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const Text('Please Enter Number Between 1 To 100'),
          TextField(
            controller: _controller,//ตัวแปร
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a number',
            ),
            ),
          //Event handler ตัวการจัดการ //callback function
          ElevatedButton(
            onPressed: handleClickGuess,
            child: const Text('Guess'),
          ),
          Text(_feedbackText),

          ElevatedButton(
            style: OutlinedButton.styleFrom(
               backgroundColor: _showTestButton ? Colors.pink : Colors.red,

            ),
            onPressed: () {},
            child: Text('Test'),
        ),
          Icon(_showTestButton ? Icons.print : Icons.access_time_rounded),
        ],
      ),
    ),
    );
  }
}
