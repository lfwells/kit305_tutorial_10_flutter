import 'package:flutter/material.dart';
import 'package:tutorial_10_flutter/character_select.dart';
import 'package:tutorial_10_flutter/character_stats.dart';

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
  late Stats characterStats;

  @override void initState() {
    super.initState();
    characterStats = Stats(hp: 0.5, atk:0.5, spd: 0.5);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Flutter App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
                IconButton.filledTonal(onPressed: () async {
                  var character = await Navigator.push<String>(context, MaterialPageRoute(builder: (context) => const CharacterSelect()));
                  if (character != null)
                  {
                    txtNameController.text = character;
                  }
                }, icon: const Icon(Icons.person)),
                IconButton.filledTonal(onPressed: () async {
                  showDialog(context: context, builder: (context) {
                    return CharacterStats(
                      initialStats: characterStats,
                      onChanged: (stats) {
                        setState(() {
                          characterStats = stats;
                        });
                      },
                    );
                  });
                }, icon: const Icon(Icons.stacked_bar_chart))
              ],
            ),
            Table(
              defaultColumnWidth: FlexColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
              children: [
                TableRow(
                  children: [
                    StatColumn(statValue: characterStats.hp, ),
                    StatColumn(statValue: characterStats.atk,),
                    StatColumn(statValue: characterStats.spd, )
                  ]
                ),
                TableRow(
                  children: [
                    Text("HP", textAlign: TextAlign.center,),
                    Text("ATK", textAlign: TextAlign.center),
                    Text("SPD", textAlign: TextAlign.center)
                  ]
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StatColumn extends StatelessWidget {
  const StatColumn({
    super.key, required this.statValue
  });

  final double statValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height:250,
        child: Stack(
          children: [
            Positioned.fill(top: statValue*250, child: Container(color: Colors.amber,)),
          ],
        )
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