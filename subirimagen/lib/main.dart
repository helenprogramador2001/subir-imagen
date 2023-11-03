import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:quickalert/quickalert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageUploadScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final List<File> _images = [];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
        print('Imagen seleccionada: ${pickedFile.path}');
      } else {
        print('No se seleccionó ninguna imagen.');
      }
    });
  }

  

          // Mostrar una alerta de éxito cuando la imagen se haya subido con éxito
          QuickAlert.show(
            // Usa QuickAlert en lugar de showDialog
            context: context,
            type: QuickAlertType.success,
            text: 'Subida de imagen correctamente!',
          );
        });
      } else {
        print("No se seleccionó ninguna imagen para subir.");
      }
    }

    // Limpiamos la lista de imágenes una vez que se subieron
    setState(() {
      _images.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subir Imágenes a Firebase"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Image.file(_images[index]);
                },
              ),
            ),
            ElevatedButton(
              onPressed: getImage,
              child: Text("Seleccionar Imágenes"),
            ),
            ElevatedButton(
              onPressed: uploadImages,
              child: Text("Subir Imágenes"),
            ),
          ],
        ),
      ),
    );
  }
}
