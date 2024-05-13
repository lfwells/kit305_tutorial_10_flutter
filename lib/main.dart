import 'package:flutter/material.dart';
import 'package:tutorial_10_flutter/character_select_screen.dart';

//this file has two pages, the tutorial solution (send data to Second Page)
//additional parts from live coding highlighted with ***
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  //if we have parameters they will go here

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
{
  //if we state values they will go here
  final TextEditingController _txtNameField = TextEditingController(text: "Starting Value");

  //*** we added some state to display the final character info here
  //see the Character_select_screen.dart file for all the new content
  String characterInfo = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold
      (
      appBar: AppBar(
        title: const Text("My Flutter App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        //*** We explored adding buttons to the top-right, the button does nothing though
        actions: [
          TextButton(onPressed: () { print("hello"); }, child: const Text("Save"))
        ],
      ),

      //*** we explored adding a drawer hamburger button, that just holds a giant save button that does nothing
      drawer: Drawer(
        width: 100,
        child: TextButton(onPressed: () { print("hello"); }, child: const Text("Save"))
      ),

      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              controller: _txtNameField,
              decoration: const InputDecoration(
                  hintText: "Enter Name",
                  labelText: "Name"
              ),
            ),

            //****** I changed the layout after the lecture a bit to give more space
            ElevatedButton(
              child:const Text("Save"),
              onPressed: () =>
              {
                //go to the next page
                //*** we explored splitting this out into its own function
                Navigator.push(context, MaterialPageRoute (
                    builder: getTheNextPage
                ),)
              },
            ),

            //*** A new button that goes to a screen in a different page
            //*** uses a "future" to await the user input from that page, and update the state
            ElevatedButton.icon(onPressed: () async
            {
              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CharacterSelectScreen()));
              print(result);
              setState(() {
                characterInfo = result;
              });
            }, icon: const Icon(Icons.people), label: const Text("Character Select")),

            Text("Character info will appear here:"),
            Text(characterInfo)
          ],
        ),
      ),
    );
  }

  //*** different to the tutorial, just a stylistic choice
  Widget getTheNextPage(BuildContext context)
  {
    return SecondPage(name: _txtNameField.text);
    //use the text selection lol
    //return SecondPage(name: _txtNameField.text.substring(_txtNameField.selection.start, _txtNameField.selection.end));
  }
}

class SecondPage extends StatelessWidget {

  //parameter storage
  final String name;

  //constructor,              with parameter list
  const SecondPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        //can get rid of back button
        //automaticallyImplyLeading: false,
        //leading: Text("Hi mom")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name),
      ),
    );
  }
}