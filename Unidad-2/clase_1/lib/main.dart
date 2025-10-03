import 'package:clase_1/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingSize = EdgeInsets.all(10.0);
    const textStyle = TextStyle(
      color: Colors.lightBlueAccent,
      fontSize: 20,
      fontWeight: FontWeight.bold
      );


    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomTextWidget(
              text: "Hola desde un widget personalizado",
              style: TextStyle(color: const Color.fromARGB(255, 101, 216, 224), fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(padding: paddingSize,
              child: Text('Hello World 1', style: textStyle,),
            ),
            Padding(padding: paddingSize,
              child: Text('Hello World 2', style: textStyle,),
            ),
            Padding(padding: paddingSize,
              child: Text('Hello World 3', style: textStyle,),
            ),
            Padding(
              padding: EdgeInsets.all(10.0), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
                  Text('Hello World 4', style: TextStyle(color: Colors.red),),
                  Text('Hello World 5'),
                  Text('Hello World 6'),
                ]
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                foregroundColor: MaterialStateProperty.all(Colors.white)

              ),
              child: Text("Click Me 1")
            ),
            TextButton(
              onPressed: () {}, 
              child: 
              Text("Click Me 2")
            ),
            OutlinedButton(
              onPressed: () {},
              child:
              Text("Click Me 3") 
            ),
            IconButton(
              onPressed: () { 
                print("Click Me 4"); 
              },
              icon: Icon(
                Icons.save,
                color: const Color.fromARGB(255, 233, 90, 90)
              )
            )
          ],),
        ),
      ),
    );
  }
}
