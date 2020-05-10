part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();
}

class TakePicture extends ScannerEvent {
    final ImageSource source;

    TakePicture({
      @required this.source,
    });

    @override
    List<Object> get props => [];
}

class FilterImage extends ScannerEvent {
    final File image;
    
    FilterImage({
      @required this.image,
    });

    @override
    List<Object> get props => [];
}

