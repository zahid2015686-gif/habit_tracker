import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// class Injector extends StatelessWidget {
//   final Widget routerWidget;
//
//   const Injector({super.key, required this.routerWidget});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: )
//       ],
//       child: routerWidget,
//     );
//   }
// }

class Injector extends StatelessWidget {
  final Widget routerWidget;

  const Injector({super.key, required this.routerWidget});

  @override
  Widget build(BuildContext context) {
    return routerWidget;
  }
}