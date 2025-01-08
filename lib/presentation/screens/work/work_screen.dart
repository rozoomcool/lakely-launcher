import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:lakely/presentation/components/todo_card.dart';
import 'package:lakely/utils/launch_apps.dart';

@RoutePage()
class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TodoCard()
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("skdlf", style: Theme.of(context).textTheme.headlineSmall,),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF292929),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("djsk;nafkjdsjk", style: TextStyle(),),
              ),
            ),
            SizedBox(height: 36,),
            SizedBox(
              width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFffa31a),
                        foregroundColor: Colors.black
                      ),
                      onPressed: () {
                    launchGoogleWithUrl("");
                  }, child: Text("fdf", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),)),
                )),
            SizedBox(height: 24,)
          ],
        ),
      ),
    );
  }
}
