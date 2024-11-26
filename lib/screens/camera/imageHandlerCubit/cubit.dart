import 'package:bloc/bloc.dart';

import 'state.dart';

class ImageHandlerCubitCubit extends Cubit<ImageHandlerCubitState> {
  ImageHandlerCubitCubit() : super(ImageHandlerCubitState().init());

  getImage(imageBase64) {
    emit(HaveImage(imageBase64: imageBase64));
  }

  DeletImage() {
    emit(HaveNotImage());
  }
}
