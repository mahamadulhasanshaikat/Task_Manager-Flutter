import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Text title',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('des'),
            SizedBox(height: 5),
            Text('date: 20/12/2026'),

            Row(
              children: [
                Chip(
                  label: Text('New', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.blue,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  color: Colors.orange,
                  icon: Icon(Icons.edit_note),
                ),
                IconButton(
                  onPressed: () {},
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
