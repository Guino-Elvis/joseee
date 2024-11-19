// import 'package:flutter/material.dart';
// import 'dart:async'; // Para usar Timer

// class SliderSection extends StatefulWidget {
//   const SliderSection({super.key});

//   @override
//   _SliderSectionState createState() => _SliderSectionState();
// }

// class _SliderSectionState extends State<SliderSection> {
//   late PageController _pageController;
//   late Timer _timer;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();

//     _timer = Timer.periodic(Duration(seconds: 6), (timer) {
//       if (_currentPage < 2) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _pageController.animateToPage(
//         _currentPage,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         children: [
//           Container(
//             height: 200,
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzJ1Fl0eNVWMHprO9vRAvg4eJTthfp97MxKBHuhBGewr_OEM8IbCYThzAsBp3AQdXw-lg&usqp=CAU',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzJ1Fl0eNVWMHprO9vRAvg4eJTthfp97MxKBHuhBGewr_OEM8IbCYThzAsBp3AQdXw-lg&usqp=CAU',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzJ1Fl0eNVWMHprO9vRAvg4eJTthfp97MxKBHuhBGewr_OEM8IbCYThzAsBp3AQdXw-lg&usqp=CAU',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
