part of 'documents_bloc_bloc.dart';

abstract class DocumentsBlocEvent extends Equatable {
  const DocumentsBlocEvent();
}

class GetDataEvent extends DocumentsBlocEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends DocumentsBlocEvent {
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}