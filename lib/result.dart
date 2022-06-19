import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.winner}) : super(key: key);
  final String winner;

  
  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        appBar: AppBar(title: const Text('Results')),
         body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                winner,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () { Navigator.pop(context, 1);},
                child: const Text('Play Again', style: TextStyle(
                  fontSize: 20,
                ),),
              ),
            TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () { Navigator.pop(context, 0);},
                child: const Text('Main Menu', style: TextStyle(
                  fontSize: 20,
                ),),
              ),
          ],
        )
      ),
      )
    
    );
  }
}
