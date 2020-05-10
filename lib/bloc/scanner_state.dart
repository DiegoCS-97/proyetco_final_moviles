part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();
}

class ScannerInitial extends ScannerState {
  @override
  List<Object> get props => [];
}


class ChoosenImage extends ScannerState {
  final File image;
  ChoosenImage({@required this.image});

  @override
  List<Object> get props => [image];
}

class FilteredImage extends ScannerState {
  final File filteredImage;
  FilteredImage({@required this.filteredImage});

  @override
  List<Object> get props => [filteredImage];
}