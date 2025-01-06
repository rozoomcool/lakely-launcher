// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart'
//     show ConsumerWidget, WidgetRef;
// import 'package:lakely/store/todo/notes_cubit.dart';
// import 'package:lakely/store/todo/todo_list.dart';
//
// class TodoCard extends ConsumerWidget {
//   const TodoCard({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var todoList = ref.watch(todoListProvider);
//
//     return SizedBox(
//       width: double.infinity,
//       height: 350,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Список дел",
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 ElevatedButton(
//                     onPressed: () => ref
//                         .read(todoListProvider.notifier)
//                         .addTodo(TodoItem("title", TodoStatus.inprogress)),
//                     child: Text("gdjfklgldfk")),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Expanded(
//                   child: ListView.separated(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     separatorBuilder: (_, __) => SizedBox(height: 4,),
//                     itemBuilder: (context, index) {
//                       return Text(todoList[index].title);
//                     },
//                     itemCount: todoList.length,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
