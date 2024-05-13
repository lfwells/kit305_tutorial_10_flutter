import 'package:flutter/material.dart';

class CharacterSelectScreen extends StatefulWidget
{
  const CharacterSelectScreen({super.key});

  //hard-coded list of names, could come from database
  static const characterNames = [
    "Rick",
    "Saul",
    "Walter",
    "Peter",
    "Hakki",
    "Lindsay",
    "Jonno",
    "Ian",
    "Stroll"
  ];

  @override
  State<CharacterSelectScreen> createState() => _CharacterSelectScreenState();
}

class _CharacterSelectScreenState extends State<CharacterSelectScreen>
{
  //here is the state of the screen
  double health = 100;
  double attack = 100;
  String selectedCharacter = "Saul";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Select"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, "$selectedCharacter\nHealth:$health\nAttack:$attack");
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //We split each of the two parts of the screen into their own functions, just to make them pretty
            buildTable(),
            buildCharacterSelector(context)
          ],
        ),
      )
    );
  }

  Widget buildTable()
  {
    //table widgets are handy, I've added some extra nuce things to it, but by defauly only needs a list of TableRow children
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(100)
      },
      children: [
        TableRow(
          children: [
            const Text("Health"),
            Slider(
              value: health,
              max: 100,
              onChanged: (value) {
                setState(() {
                  health = value;
                });
              }
            )
          ]
        ),
        TableRow(
          children: [
            const Text("Attack"),
            Slider(
              value: attack,
              max: 100,
              onChanged: (value) {
                setState(() {
                  attack = value;
                });
              }
            )
          ]
        ),
      ],
    );
  }

  Widget buildCharacterSelector(BuildContext context)
  {
    //HIGHER ORDER FUNCTIONS (map, where), LEARN THEM

    //filter the list using where then transform the list using map
    List<DropdownMenuItem<String>> dropdownItems = CharacterSelectScreen.characterNames.where((element) => element.startsWith("S")).map(createDropdownItemFromString).toList();

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        label: const Text("Character Name"),
        helperText: selectedCharacter == "Stroll" ? "Poor choice" :  "Select it or die"
      ),
      value: selectedCharacter,
      items: dropdownItems,
      onChanged: (selected) {
        setState(() {
          selectedCharacter = selected!;
        });
        //in event-based frameworks, we would have to do this, WE CANT DO THIS IN FLUTTER
        //if (selectedCharacter == "stroll") { find the dropdown, set its helptext...}
      }
    );
  }

  //transformation function
  DropdownMenuItem<String> createDropdownItemFromString(String input)
  {
    return DropdownMenuItem(value: input, child: Row(
      children: [
        const Icon(Icons.person),
        Text(input),
      ],
    ));
  }
}
