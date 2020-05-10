import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/documents/bloc/documents_bloc_bloc.dart';
import 'package:proyecto/documents/item_file.dart';

class Files extends StatefulWidget {
  Files({Key key}) : super(key: key);

  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  DocumentsBlocBloc bloc;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis documentos"),
      ),
      body: BlocProvider(
        create: (context) {
          bloc = DocumentsBlocBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<DocumentsBlocBloc, DocumentsBlocState>(
          listener: (context, state) {
            if (state is CloudStoreRemoved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha eliminado el elemento."),
                  ),
                );
            } else if (state is CloudStoreError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("${state.errorMessage}"),
                  ),
                );
            } else if (state is CloudStoreGetData) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Descargando datos..."),
                  ),
                );
            }
          },
          child: BlocBuilder<DocumentsBlocBloc, DocumentsBlocState>(
            builder: (context, state) {
              if (state is DocumentsBlocInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: bloc.getDocumentsList.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ItemDocument(
                    key: UniqueKey(),
                    index: index,
                    url: bloc.getDocumentsList[index].documentUrl,
                    nombre: bloc.getDocumentsList[index].name ?? "No name",
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
