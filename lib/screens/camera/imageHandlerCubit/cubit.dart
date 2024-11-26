import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';

import 'state.dart';

class ImageHandlerCubit extends Cubit<ImageHandlerState> {
  ImageHandlerCubit() : super(ImageHandlerState().init());

  getImage(imageBase64) {
    Uint8List bytesImage = base64Decode(imageBase64);
    emit(HaveImage(imageByte: bytesImage));
  }

  DeletImage() {
    emit(HaveNotImage());
  }
}
