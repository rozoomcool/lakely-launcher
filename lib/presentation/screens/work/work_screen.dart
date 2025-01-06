import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lakely/presentation/components/todo_card.dart';

@RoutePage()
class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // TodoCard()
          ElevatedButton(onPressed: () {}, child: Text("Hello World")),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("kjfsaksdjkflj;slkdjf"),
            ),
          ),
        ],
      ),
    );
  }
}