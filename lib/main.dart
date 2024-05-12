import 'package:flutter/material.dart';

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

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
{

  var txtNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Flutter App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: txtNameController,
                decoration: const InputDecoration(
                    hintText: "Enter Name",
                    labelText: "Name"
                ),
              ),
            ),
            ElevatedButton(
              child:const Text("Save"),
              onPressed: () =>
              {
                //Navigate to second screen with data
                Navigator.push(context, MaterialPageRoute(
                    builder:(context) => SecondPage(name: txtNameController.text)
                ))
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {

  final String name;

  const SecondPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name),
      ),
    );
  }
}