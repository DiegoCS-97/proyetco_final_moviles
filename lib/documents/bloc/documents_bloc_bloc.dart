import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:proyecto/documents/document.dart';

part 'documents_bloc_event.dart';
part 'documents_bloc_state.dart';

class DocumentsBlocBloc extends Bloc<DocumentsBlocEvent, DocumentsBlocState> {
  final Firestore _firestoreInstance = Firestore.instance;

  @override
  DocumentsBlocState get initialState => DocumentsBlocInitial();
  List<Document> _pdfList;
  List<DocumentSnapshot> _documentsList;
  List<Document> get getDocumentsList => _pdfList;

  @override
  Stream<DocumentsBlocState> mapEventToState(
    DocumentsBlocEvent event,
  ) async* {
    if (event is GetDataEvent) {
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se ha podido conseguir datos.",
        );
    } else if (event is RemoveDataEvent) {
      try {
        await _documentsList[event.index].reference.delete();
        _documentsList.removeAt(event.index);
        _pdfList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    }
  }

  Future<bool> _getData() async {
    try {
      var documents =
          await _firestoreInstance.collection("documentos").getDocuments();
      _pdfList = documents.documents
          .map(
            (pdfFile) => Document(
              name: pdfFile["Nombre"],
              documentUrl: pdfFile["URL"],
            ),
          )
          .toList();
      _documentsList = documents.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
