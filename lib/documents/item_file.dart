import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/documents/bloc/documents_bloc_bloc.dart';
import 'package:proyecto/pdf_viewer.dart';
import 'package:flutter_share/flutter_share.dart';

class ItemDocument extends StatefulWidget {
  final String url;
  final String nombre;
  final int index;
  ItemDocument(
      {Key key,
      @required this.url,
      @required this.nombre,
      @required this.index})
      : super(key: key);

  @override
  _ItemDocumentState createState() => _ItemDocumentState();
}

class _ItemDocumentState extends State<ItemDocument> {
  DocumentsBlocBloc _pdfBloc;
  File tempFile;
  @override
  Widget build(BuildContext context) {
    _pdfBloc = BlocProvider.of<DocumentsBlocBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => PDFViewer(
            url: widget.url,
            name: widget.nombre,
          ),
        ));
      },
      child: Container(
        child: Card(
          margin: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Container(
                      child: Text(
                        "${widget.nombre}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () async {
                      await FlutterShare.share(
                          title: 'Example share',
                          linkUrl: widget.url,
                          text:
                              "'${widget.nombre}.pdf' enviado desde nuestra app:",
                          chooserTitle: 'Enviar archivo');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Borrar documento"),
                          content: Text("¿Seguro que quiere borrar?"),
                          actions: <Widget>[
                            MaterialButton(
                              child: Text("Cancerlar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            MaterialButton(
                              child: Text("Borrar"),
                              onPressed: () {
                                _pdfBloc.add(
                                  RemoveDataEvent(index: widget.index),
                                );
                                Navigator.of(context).pop();
                                _pdfBloc.add(GetDataEvent());
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
