import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/photofilters.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as Path;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:printing/printing.dart';

import 'bloc/scanner_bloc.dart';

class EscanerPage extends StatefulWidget {
  final bool option;
  EscanerPage({Key key, this.option}) : super(key: key);

  @override
  _EscanerPageState createState() => _EscanerPageState();
}

class _EscanerPageState extends State<EscanerPage> {
  File _selectedFile;
  bool _inProcess = false;
  final key = new GlobalKey<ScaffoldState>();

  ScannerBloc _mainbloc;
  final Firestore _firestoreInstance = Firestore.instance;
  final StorageReference storageReference = FirebaseStorage.instance.ref();
  var doc = pw.Document();
  final titleController = TextEditingController();
  final focus = FocusNode();

//Pantalla principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escaner')),
      body: BlocProvider(
        create: (context) {
          _mainbloc = ScannerBloc();
          return _mainbloc;
        },
        child: BlocBuilder<ScannerBloc, ScannerState>(
          builder: (context, _appBloc) {
            if (_appBloc is ChoosenImage) {
              _selectedFile = _appBloc.image;
            }
            return SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        getImageWidget(),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: TextField(
                              controller: titleController,
                              focusNode: focus,
                              enabled: _selectedFile == null ? false : true,
                              decoration: InputDecoration(
                                hintText: "Introduzca nombre",
                                prefixIcon: Icon(Icons.insert_drive_file,
                                    color: Colors.grey),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () async {
                                widget.option == false
                                    ? _mainbloc.add(
                                        TakePicture(source: ImageSource.camera))
                                    : _mainbloc.add(TakePicture(
                                        source: ImageSource.gallery));
                                titleController.clear();

                                //getImage(ImageSource.camera);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      widget.option == false
                                          ? 'Tomar foto'
                                          : 'Seleccionar foto',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Icon(Icons.camera_alt, color: Colors.white),
                                  ],
                                ),
                              ),
                              color: Colors.cyan[300],
                            ),
                            SizedBox(width: 20),
                            RaisedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Agregar filtro',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Icon(Icons.filter_b_and_w,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                              color: Colors.cyan[300],
                              onPressed: () {
                                _selectedFile == null
                                    ? Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('No has escaneado nada'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      )
                                    : agregarFiltro(context);
                              },
                            ),
                          ],
                        ),
                        //TODO: Generar pdf con imagen
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () async {
                            File pic = _selectedFile;

                            if (_selectedFile == null) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No has escaneado nada'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            } else if (titleController.text == '') {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Campo de titulo vacio'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              focus.requestFocus();
                            } else {
                              generateFile(_selectedFile);
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('PDF creado'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Guardar como PDF',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(Icons.picture_as_pdf, color: Colors.white),
                              ],
                            ),
                          ),
                          color: Colors.cyan[300],
                        ),
                      ],
                    ),
                  ),
                  (_inProcess)
                      ? Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.95,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Center()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void savePdfData(String title, String url) async {
    try {
      await _firestoreInstance.collection('documentos').document().setData(
        {'Nombre': title, 'URL': url},
      );
    } catch (err) {
      print(err.toString());
    }
  }

  generateFile(File _selectedFile) async {
    pw.Document doc = pw.Document();

    final image = PdfImage.file(
      doc.document,
      bytes: _selectedFile.readAsBytesSync(),
    );

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: pw.EdgeInsets.all(0),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.FittedBox(
              fit: pw.BoxFit.fill,
              child: pw.Image(image),
            ),
          );
        }));

    final output = await getTemporaryDirectory();
    final fileDoc = File("${output.path}/${titleController.text}.pdf");
    await fileDoc.writeAsBytes(doc.save());

    String url = await _uploadFile(fileDoc);
    savePdfData(titleController.text, url);
  }

  Future _uploadFile(File choosenFile) async {
    String filePath = choosenFile.path;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("documentos/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(choosenFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((pdfURL) {
      print("Link>>>>> $pdfURL");
    });

    return reference.getDownloadURL();
  }

  //Checa si ya se eligio una imagen, si no muestra una de assets
  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
        child: AspectRatio(
          aspectRatio: 1 / 1.2941,
          child: Image.file(
            _selectedFile,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
        child: AspectRatio(
          aspectRatio: 1 / 1.2941,
          child: Image.asset(
            "assets/images/placeholder.jpg",
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Future agregarFiltro(context) async {
    Map imagefile = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: Text("Agregar Filtro"),
          image: imageLib.decodeImage(_selectedFile.readAsBytesSync()),
          filters: [
            NoFilter(),
            InkwellFilter(),
            XProIIFilter(),
            MavenFilter(),
            WillowFilter()
          ],
          filename: basename(_selectedFile.path),
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      _selectedFile = imagefile['image_filtered'];
      _mainbloc.add(FilterImage(image: _selectedFile));
    }
  }
}
