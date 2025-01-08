import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:lakely/presentation/components/todo_card.dart';
import 'package:lakely/utils/app_colors.dart';
import 'package:lakely/utils/launch_apps.dart';
import 'package:lakely/utils/status_and_navigation_bar_color.dart';

@RoutePage()
class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setUiModeFullScreenImmersiveSticky();
    return Scaffold(
      backgroundColor: AppSettings.colors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppSettings.colors.cardColor,
            floating: false,
            pinned: true,
            expandedHeight: 130.0,
            stretch: true,
            actions: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.settings_rounded))
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              // background: Image.network(
              //   "https://people.com/thmb/FaB_SWxr0Ko0rF_UpZfA9MF_Qcg=/4000x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(449x499:451x501)/Skims_Swimsuit-002-28505f0f771149529c3015a05fd9a6b1.jpg",
              //   fit: BoxFit.cover,
              //   scale: 1.5,
              // ),
              titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              expandedTitleScale: 1.3,
              title: Text("Блокнот"),
            ),
          ),
          SliverAnimatedList(
              initialItemCount: 30,
              itemBuilder: (context, index, animation) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: ListTile(
                      tileColor: AppSettings.colors.cardColor,
                      title: Text("Title"),
                      subtitle: Text("16/04/2004"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppSettings.colors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.view_list_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.grid_view_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.account_tree_rounded)),
          ],
        ),
      ),
    );
  }
}
