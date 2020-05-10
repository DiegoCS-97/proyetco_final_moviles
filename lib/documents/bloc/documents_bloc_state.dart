part of 'documents_bloc_bloc.dart';

abstract class DocumentsBlocState extends Equatable {
  const DocumentsBlocState();
}

class DocumentsBlocInitial extends DocumentsBlocState {
  @override
  List<Object> get props => [];
}

class CloudStoreError extends DocumentsBlocState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends DocumentsBlocState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends DocumentsBlocState {
  @override
  List<Object> get props => [];
}