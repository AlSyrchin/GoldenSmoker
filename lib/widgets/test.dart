// import 'dart:math';
// import 'package:flutter/material.dart';





// class Bank extends StatefulWidget {
//   const Bank({super.key});

//   @override
//   State<Bank> createState() => _BankState();
// }

// class _BankState extends State<Bank> {
//   @override
//   void initState() {
//     super.initState();
//     generate();
//   }

//   List<Recent> recent = [];

//   void generate() {
//     recent = List<Recent>.generate(
//         Random().nextInt(9) + 1,
//         (index) => Recent('Payment',
//             const Icon(Icons.monetization_on, color: Colors.black45)),
//         growable: true);
//   }

//   Widget spisok2() {
//     return Expanded(
//         child: ListView.builder(
//             itemCount: recent.length,
//             itemBuilder: (_, index) => Card(
//                   child: ListTile(
//                     onTap: () {},
//                     title: Text(recent[index].name),
//                     subtitle: Text(recent[index].data),
//                     leading: recent[index].icon,
//                     trailing: Text(
//                       recent[index].price.toString(),
//                       style: TextStyle(
//                           color: recent[index].price > 0 ? colGr : colRed),
//                     ),
//                   ),
//                 )));
//   }

//   Widget area1(TextTheme _textTheme) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome back',
//                       style: _textTheme.headlineSmall,
//                     ),
//                     Text(
//                       'Anarda',
//                       style: _textTheme.headlineLarge,
//                     ),
//                   ],
//                 ),
//                 const CircleAvatar(
//                   backgroundImage: AssetImage('image/img.png'),
//                   radius: 20,
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(bottom: 20)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                           colors: [
//                             colorGreen,
//                             Color.fromRGBO(57, 133, 41, 0.9),
//                           ],
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.bottomRight),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   width: 250,
//                   height: 130,
//                   child: Center(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '\$ 1,929.21',
//                         style: _textTheme.headlineLarge,
//                       ),
//                       Text('1845 5123 1564 6785',
//                           style: _textTheme.headlineMedium)
//                     ],
//                   )),
//                 ),
//                 Container(
//                   width: 40,
//                   height: 130,
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                           colors: [
//                             colorGray,
//                             Color.fromRGBO(58, 58, 58, 0.9),
//                           ],
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.bottomRight),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: OutlinedButton(
//                     onPressed: () {},
//                     child: const Icon(
//                       Icons.add,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(bottom: 20)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     OutlinedButton(
//                       style: ButtonStyle(
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(btnBorder)))),
//                       onPressed: () {},
//                       child: const Icon(
//                         Icons.send,
//                         color: colorGreen,
//                       ),
//                     ),
//                     const Padding(padding: EdgeInsets.only(bottom: 10)),
//                     Text(
//                       'Send',
//                       style: _textTheme.headlineSmall,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     OutlinedButton(
//                       style: ButtonStyle(
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(btnBorder)))),
//                       onPressed: () {},
//                       child: const Icon(
//                         Icons.request_page,
//                         color: colorGreen,
//                       ),
//                     ),
//                     const Padding(padding: EdgeInsets.only(bottom: 10)),
//                     Text(
//                       'Request',
//                       style: _textTheme.headlineSmall,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     OutlinedButton(
//                       style: ButtonStyle(
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(btnBorder)))),
//                       onPressed: () {
//                         setState(() {
//                           ttl.isDark() ? ttl.light() : ttl.dark();
//                           // print(ttl.theme);
//                         });
//                       },
//                       child: const Icon(
//                         Icons.payments_outlined,
//                         color: colorGreen,
//                       ),
//                     ),
//                     const Padding(padding: EdgeInsets.only(bottom: 10)),
//                     Text(
//                       'Theme',
//                       style: _textTheme.headlineSmall,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     OutlinedButton(
//                       style: ButtonStyle(
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(btnBorder)))),
//                       onPressed: () {
//                         setState(() {
//                           generate();
//                         });
//                       },
//                       child: const Icon(
//                         Icons.more_horiz,
//                         color: colorGreen,
//                       ),
//                     ),
//                     const Padding(padding: EdgeInsets.only(bottom: 10)),
//                     Text(
//                       'More',
//                       style: _textTheme.headlineSmall,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.only(bottom: 20)),
//             Expanded(
//               child: Container(
//                 color: Colors.amber,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Recent trancactions',
//                       style: _textTheme.headlineLarge,
//                     ),
//                     spisok2(),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget area2() {
//     return Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(colors: [
//         colorGreen,
//         Color.fromRGBO(41, 94, 30, 1.0),
//       ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//       //color: colorGrayLite,
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               const Text(
//                 'Easy Way to Save Your Money',
//                 style: TextStyle(fontSize: 40, color: Colors.white),
//               ),
//               const Padding(padding: EdgeInsets.only(bottom: 10)),
//               const Text(
//                 'The best place to transact and save money',
//                 style: TextStyle(fontSize: 10, color: Colors.white),
//               ),
//               const Padding(padding: EdgeInsets.only(bottom: 10)),
//               Container(
//                   width: 400,
//                   height: 40,
//                   child: OutlinedButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'Get Started',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: OutlinedButton.styleFrom(
//                       backgroundColor: colorGreen,
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextTheme _textTheme = Theme.of(context).textTheme;
//     const List<Widget> tabs = [
//       Tab(icon: Icon(Icons.home)),
//       Tab(icon: Icon(Icons.graphic_eq)),
//       Tab(icon: Icon(Icons.memory_rounded)),
//       Tab(icon: Icon(Icons.people_alt)),
//     ];

//     return DefaultTabController(
//       initialIndex: 1,
//       length: tabCount,
//       child: Scaffold(
//         bottomNavigationBar: BottomAppBar(
//           child: Container(
//             height: 60.0,
//             child: TabBar(
//                 indicatorColor: colorGray,
//                 tabs: tabs.map((Widget el) => el).toList()),
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             area2(),
//             area1(_textTheme),
//             Container(
//               color: Colors.amber,
//             ),
//             const Home(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ////////////////////////////////////////////////////////////////////

// //////////////////////////////////////////////////////////////////////////

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late String _userTo;
//   List toList = [];

//   @override
//   void initState() {
//     super.initState();
//     toList.addAll(['Milk', 'Coocke', 'Drink', 'Spasy']);
//   }

//   void _menuOpen() {
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (BuildContext context) {
//       return Scaffold(
//           appBar: AppBar(
//             title: const Text('Menu'),
//           ),
//           body: Row(
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, '/', (route) => false);
//                   },
//                   child: const Text('In main menu')),
//               const Padding(padding: EdgeInsets.only(left: 15)),
//               const Text('My menu')
//             ],
//           ));
//     }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       appBar: AppBar(
//         title: const Text('Planer'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: _menuOpen, icon: const Icon(Icons.menu_open_outlined))
//         ],
//       ),
//       body: ListView.builder(
//           itemCount: toList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Dismissible(
//               key: Key(toList[index]),
//               child: Card(
//                 child: ListTile(
//                   title: Text(toList[index]),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.delete_outline,
//                       color: Colors.amber,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         toList.removeAt(index);
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               onDismissed: (direction) {
//                 //if (direction == DismissDirection.endToStart)
//                 setState(() {
//                   toList.removeAt(index);
//                 });
//               },
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         backgroundColor: Colors.lightGreen,
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Add element'),
//                   content: TextField(
//                     onChanged: (String value) {
//                       _userTo = value;
//                     },
//                   ),
//                   actions: [
//                     ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             toList.add(_userTo);
//                           });
//                           Navigator.of(context).pop();
//                         },
//                         child: const Text('Add'))
//                   ],
//                 );
//               });
//         },
//       ),
//     );
//   }
// }
