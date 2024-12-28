import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.icon,
    required this.countNotifier,
  });

  final IconData icon;
  final ValueNotifier<int> countNotifier;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: countNotifier,
        builder: (BuildContext context, int count, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 100,
                ),
                SizedBox(height: 10),
                Text(
                  '$count',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        if (count > 0) {
                          countNotifier.value--;
                        }
                      },
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      iconSize: 32,
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        countNotifier.value++;
                      },
                      icon: Icon(Icons.add),
                      color: Colors.green,
                      iconSize: 32,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
