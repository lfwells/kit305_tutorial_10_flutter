import 'package:flutter/material.dart';

class Stats
{
  double hp;
  double atk;
  double spd;

  Stats({ required this.hp, required this.atk, required this.spd });
}
class CharacterStats extends StatefulWidget
{
  const CharacterStats({super.key, required this.initialStats, required this.onChanged});

  final Stats initialStats;
  final Function(Stats) onChanged;

  @override
  State<CharacterStats> createState() => _CharacterStatsState();
}

class _CharacterStatsState extends State<CharacterStats>
{
  late Stats currentStats;

  @override void initState() {
    super.initState();

    currentStats = widget.initialStats;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Character Stats"),
      content: Table(
        defaultColumnWidth: FixedColumnWidth(40),
        columnWidths: { 1: FlexColumnWidth()},
        children: [
          TableRow(
            children: [
              Text("HP"),
              Slider(value: currentStats.hp, onChanged: (val) {
                setState(() {
                  currentStats.hp = val;
                });
                widget.onChanged(currentStats);
              }),
              Text(currentStats.hp.toStringAsFixed(1))
            ],
          ),
          TableRow(
              children: [
                Text("ATK"),
                Slider(value: currentStats.atk, onChanged: (val) {
                  setState(() {
                    currentStats.atk = val;
                  });
                  widget.onChanged(currentStats);
                }),
                Text(currentStats.atk.toStringAsFixed(1))
              ]
          ),
          TableRow(
              children: [
                Text("SPD"),
                Slider(value: currentStats.spd, onChanged: (val) {
                  setState(() {
                    currentStats.spd = val;
                  });
                  widget.onChanged(currentStats);
                }),
                Text(currentStats.spd.toStringAsFixed(1))
              ]
          )
        ],
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("CLOSE"))
      ],
    );
  }
}
