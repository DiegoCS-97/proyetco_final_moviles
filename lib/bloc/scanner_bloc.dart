import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  File _selectedFile;
  @override
  ScannerState get initialState => ScannerInitial();

  @override
  Stream<ScannerState> mapEventToState(
    ScannerEvent event,
  ) async* {
    if (event is TakePicture) {
      if (event.source == ImageSource.camera) {
        await getImage(ImageSource.camera);
      } else {
        await getImage(ImageSource.gallery);
      }
      yield ChoosenImage(image: _selectedFile);
    } else if (event is FilterImage) {
      _selectedFile = event.image;
      yield FilteredImage(filteredImage: _selectedFile);
    }
  }

  //Es el metodo para elegir una imagen, acepta si es de la galeria o de la camara
  getImage(ImageSource source) async {
    //Eleccion de imagen
    File image = await ImagePicker.pickImage(source: source);
    CropAspectRatio hola = CropAspectRatio(ratioX: 1, ratioY: 1.2941);
    if (image != null) {
      //Inicia la parte del cropper que es una Activity del manifest
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: hola,
          compressQuality: 100,
          maxWidth: 1000,
          maxHeight: 1000,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blue[100],
            toolbarTitle: "Ajuste",
            statusBarColor: Colors.blue[100],
            backgroundColor: Colors.white,
          ));
      //Regresa la imagen modificada y cambia el estado
      _selectedFile = cropped;
    }
  }
}
