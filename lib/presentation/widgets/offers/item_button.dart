import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final IconData icon;
  final ValueNotifier<int> countNotifier;

  const ItemButton({
    super.key,
    required this.icon,
    required this.countNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: countNotifier,
      builder: (context, count, _) {
        return Container(
          width: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                children: [
                  IconButton(
                    onPressed: () {
                      if (count > 0) countNotifier.value--;
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
    );
  }
}
