// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:front_flutter_api_rest/src/controller/categoriaController.dart';
// import 'package:front_flutter_api_rest/src/controller/sub_categoriaController.dart';
// import 'package:front_flutter_api_rest/src/model/categoriaModel.dart';
// import 'package:front_flutter_api_rest/src/model/subCategoriaModel.dart';
// import 'package:front_flutter_api_rest/src/providers/theme.dart';
// import 'package:provider/provider.dart';

// class SubCategoriSection extends StatefulWidget {
//   const SubCategoriSection({Key? key});

//   @override
//   State<SubCategoriSection> createState() => _SubCategoriSectionState();
// }

// class _SubCategoriSectionState extends State<SubCategoriSection> {
//   List<SubCategoriaModel> item = [];
//   SubCategoriaController subCategoriaController = SubCategoriaController();

//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   Future<void> _getData() async {
//     try {
//       final subCategoriesData =
//           await subCategoriaController.getDataSubCategoria();

//       setState(() {
//         item = subCategoriesData
//             .map<SubCategoriaModel>((json) => SubCategoriaModel.fromJson(json))
//             .toList();
//       });
//     } catch (error) {
//       print('Error fetching categories: $error');
//     }
//   }

//   //  void _navigateToCategoryView(int categoryId) {
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => CategoriDetail(categoryId: categoryId),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();
//     final themeColors = themeProvider.getThemeColors();

//     return BounceInUp(
//       duration: Duration(milliseconds: 900),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: item.map<Widget>((subcategoria) {
//             return Container(
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               decoration: BoxDecoration(
//                 color: themeProvider.isDiurno ? themeColors[2] : themeColors[0],
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 0,
//                     blurRadius: 4,
//                     offset: Offset(2, 0),
//                   ),
//                 ],
//               ),
//               child: InkWell(
//                 onTap: () {
//                   // _navigateToCategoryView(categoria.id);
//                 },
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Transform.rotate(
//                       angle: 90 *
//                           3.1415926535 /
//                           180, // Rota 90 grados hacia la derecha
//                       child: Icon(
//                         Icons.local_offer,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       subcategoria.nombre ?? 'No hay subcategoria',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
