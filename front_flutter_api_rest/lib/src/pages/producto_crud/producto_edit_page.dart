import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/components/app_bar_edit.dart';
import 'package:front_flutter_api_rest/src/controller/imagenController.dart';
import 'package:front_flutter_api_rest/src/controller/productoController.dart';
import 'package:front_flutter_api_rest/src/controller/sub_categoriaController.dart';
import 'package:front_flutter_api_rest/src/model/urlModel.dart';
import 'package:front_flutter_api_rest/src/model/productoModel.dart';
import 'package:front_flutter_api_rest/src/providers/theme.dart';
import 'package:front_flutter_api_rest/src/routes/route.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductoEditPage extends StatefulWidget {
  final ProductoModel item;

  ProductoEditPage({required this.item});

  @override
  _ProductoEditPageState createState() => _ProductoEditPageState();
}

class _ProductoEditPageState extends State<ProductoEditPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKeyUrl = GlobalKey<FormState>(); // Clave para el formulario de URL
  final _nombreController = TextEditingController();
  final _descripController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();

  //para crear imagenes
  // File? selectedImageURL;
  List<File> selectedImages = []; // Lista de imágenes seleccionadas
  //end para crear imagenes

  String? selectedSubCategoria;
  String? selectedEstado;
  File? selectedImage; // Para almacenar la imagen seleccionada

  // ImagenController imagenController = ImagenController();
  ProductoController productoController = ProductoController();
  SubCategoriaController subCategoriaController = SubCategoriaController();
  List<Map<String, dynamic>> subCategorias = [];
  @override
  void initState() {
    super.initState();
    _getData();
    // Cargar los datos del producto en los controladores
    _nombreController.text = widget.item.nombre ?? '';
    _descripController.text = widget.item.descrip ?? '';
    _precioController.text = widget.item.precio?.toString() ?? '';
    _stockController.text = widget.item.stock ?? '';
    selectedEstado = widget.item.estado ?? '';
    selectedSubCategoria = widget.item.subCategoria?['id']?.toString();
  }

  Future<void> _getData() async {
    try {
      print("Fetching subcategories");
      final subCategoriesData =
          await subCategoriaController.getDataSubCategoria();
      setState(() {
        subCategorias = List<Map<String, dynamic>>.from(subCategoriesData);
      });
    } catch (error) {
      print("Error fetching subcategories: $error");
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path); // Asigna la imagen seleccionada
      });
    }
  }

  Future<void> _pickImagesURL() async {
    final picker = ImagePicker();
    final pickedFiles =
        await picker.pickMultiImage(); // Selecciona múltiples imágenes
    if (pickedFiles != null) {
      setState(() {
        // Asigna todas las imágenes seleccionadas a la lista selectedImages
        selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<List<String?>> _uploadImageURL(List<File> images, String title) async {
    List<String?> downloadUrls =
        []; // Lista para almacenar las URLs de descarga

    try {
      for (var image in images) {
        final fileName =
            'imagenes/$title-${DateTime.now().millisecondsSinceEpoch}.png'; // Usamos un timestamp para evitar conflictos en los nombres
        final firebaseStorageReference =
            FirebaseStorage.instance.ref().child(fileName);

        // Subir cada imagen a Firebase Storage
        await firebaseStorageReference.putFile(image);

        // Obtener la URL de descarga de la imagen
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        downloadUrls.add(downloadUrl); // Agregar la URL de descarga a la lista
      }

      return downloadUrls; // Retornar la lista con todas las URLs
    } catch (error) {
      print("Error uploading images: $error");
      return []; // Retornar una lista vacía en caso de error
    }
  }

  void _editarProducto() async {
    String newImageUrl = widget.item.foto ?? "";
    int? itemId = widget.item.id;
    String title = widget.item.nombre.toString();

    if (selectedImage != null) {
      String fileName = 'venta/$itemId-$title.png';
      final firebaseStorageReference =
          FirebaseStorage.instance.ref().child(fileName);

      try {
        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        if (downloadUrl != null) {
          newImageUrl = downloadUrl; // Actualizar URL de la imagen
        }
      } catch (e) {
        print("Error al cargar la imagen: $e");
      }
    }
    double? precio = double.tryParse(_precioController.text);
    final productoEditado = ProductoModel(
      id: widget.item.id,
      nombre: _nombreController.text,
      descrip: _descripController.text,
      precio: precio,
      stock: _stockController.text,
      estado: selectedEstado ?? "",
      subCategoria: {'id': selectedSubCategoria},
      foto: newImageUrl,
    );

    final response = await productoController.editarProducto(productoEditado);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto actualizado con éxito')),
      );
      Navigator.pushNamed(context, AppRoutes.productoListRoute);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar Producto')),
      );
    }
  }

// // Función para crear todas las imágenes seleccionadas
//   void _crearImagen() async {
//     if (_formKeyUrl.currentState!.validate()) {
//       if (selectedImages.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Por favor, seleccione al menos una imagen')),
//         );
//         return;
//       }
//       List<String?> downloadUrls =
//           await _uploadImageURL(selectedImages, widget.item.nombre.toString());
//       if (downloadUrls.isNotEmpty) {
//         for (var downloadUrl in downloadUrls) {
//           final nuevaImagen = UrlModel(
//             url: downloadUrl ?? '',
//             producto: {'id': widget.item.id.toString()},
//           );

//           try {
//             final response = await imagenController.crearImagen(nuevaImagen);
//             if (response.statusCode == 200 || response.statusCode == 201) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Imagen creada con éxito')),
//               );
//               Navigator.pushNamed(context, AppRoutes.productoListRoute);
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                     content:
//                         Text('Error al crear la imagen: ${response.body}')),
//               );
//             }
//           } catch (e) {
//             print('Error al crear imagen: $e');
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error al crear imagen: $e')),
//             );
//           }
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(
//                   'No se pudo obtener la URL de descarga de las imágenes')),
//         );
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: themeProvider.isDiurno ? themeColors[1] : themeColors[7],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarEdit(
                onBackTap: () {
                  Navigator.pushNamed(context, AppRoutes.productoListRoute);
                },
              ),
              Center(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.item.foto.toString(),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/nofoto.jpg'),
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: themeProvider.isDiurno
                        ? themeColors[2]
                        : themeColors[0],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: themeProvider.isDiurno ? themeColors[2] : themeColors[7],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                            _nombreController, 'Nombre', themeProvider),
                        SizedBox(height: 20),
                        _buildTextField(
                            _descripController, 'Descripcion', themeProvider),
                        SizedBox(height: 20),
                        _buildTextField(
                            _precioController, 'Precio', themeProvider),
                        SizedBox(height: 20),
                        _buildTextField(
                            _stockController, 'Stock', themeProvider),
                        SizedBox(height: 20),
                        _buildDropdownEstado(themeProvider),
                        SizedBox(height: 20),
                        _buildDropdownSubCategoria(themeProvider),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Seleccionar Imagen',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 10),
                        if (selectedImage != null)
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                selectedImage!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: _editarProducto,
                              child: Text('Actualizar Producto'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.productoListRoute);
                              },
                              child: Text('Regresar'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: themeProvider.isDiurno ? themeColors[2] : themeColors[7],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKeyUrl,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: widget.item.imagenes?.length ?? 0,
                                itemBuilder: (context, index) {
                                  var imagen = widget.item.imagenes![index];
                                  return Stack(
                                    children: [
                                      // Imagen
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          widget.item.imagenes![index].url ??
                                              'URL no disponible',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Icono de corazón
                                      // Positioned(
                                      //   top: 8,
                                      //   right: 8,
                                      //   child: InkWell(
                                      //     onTap: () async {
                                      //       var response =
                                      //           await imagenController
                                      //               .removeImagen(imagen.id!,
                                      //                   imagen.url ?? '');
                                      //       if (response.statusCode == 200 ||
                                      //           response.statusCode == 204) {
                                      //         ScaffoldMessenger.of(context)
                                      //             .showSnackBar(
                                      //           SnackBar(
                                      //               content: Text(
                                      //                   'Imagen eliminada con éxito')),
                                      //         );
                                      //         setState(() {
                                      //           widget.item.imagenes
                                      //               ?.removeAt(index);
                                      //         });
                                      //       } else {
                                      //         ScaffoldMessenger.of(context)
                                      //             .showSnackBar(
                                      //           SnackBar(
                                      //               content: Text(
                                      //                   'Error al eliminar la imagen')),
                                      //         );
                                      //       }
                                      //     },
                                      //     child: Icon(
                                      //       Icons.delete,
                                      //       color: Colors.red,
                                      //       size: 24,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFieldCRE(TextEditingController controller,
      String label, ThemeProvider themeProvider) {
    final themeColors = themeProvider.getThemeColors();
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: themeProvider.isDiurno ? themeColors[7] : themeColors[2],
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: themeProvider.isDiurno ? themeColors[10] : themeColors[9],
        ),
        filled: true,
        fillColor: themeProvider.isDiurno ? themeColors[1] : themeColors[7],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $label';
        }
        return null;
      },
    );
  }

  TextFormField _buildTextField(TextEditingController controller, String label,
      ThemeProvider themeProvider) {
    final themeColors = themeProvider.getThemeColors();
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: themeProvider.isDiurno ? themeColors[7] : themeColors[2],
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: themeProvider.isDiurno ? themeColors[10] : themeColors[9],
        ),
        filled: true,
        fillColor: themeProvider.isDiurno ? themeColors[1] : themeColors[7],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _buildDropdownEstado(
      ThemeProvider themeProvider) {
    final themeColors = themeProvider.getThemeColors();
    return DropdownButtonFormField<String>(
      value: selectedEstado,
      onChanged: (String? newValue) {
        setState(() {
          selectedEstado = newValue;
        });
      },
      items: ['Activo', 'Inactivo'].map((String estado) {
        return DropdownMenuItem<String>(
          value: estado,
          child: Text(
            estado,
            style: TextStyle(color: Colors.blue),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Estado',
        filled: true,
        fillColor: themeProvider.isDiurno ? themeColors[1] : themeColors[7],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _buildDropdownSubCategoria(
      ThemeProvider themeProvider) {
    final themeColors = themeProvider.getThemeColors();
    return DropdownButtonFormField<String>(
      value: selectedSubCategoria,
      onChanged: (String? newValue) {
        setState(() {
          selectedSubCategoria = newValue;
        });
      },
      items: subCategorias.map<DropdownMenuItem<String>>((subCategoria) {
        return DropdownMenuItem<String>(
          value: subCategoria['id'].toString(),
          child: Text(
            subCategoria['nombre'],
            style: TextStyle(color: Colors.blue),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Sub Categoría',
        filled: true,
        fillColor: themeProvider.isDiurno ? themeColors[1] : themeColors[7],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
