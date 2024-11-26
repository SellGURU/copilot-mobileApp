class ImageHandlerCubitState {
  ImageHandlerCubitState init() {
    return ImageHandlerCubitState();
  }

  ImageHandlerCubitState clone() {
    return ImageHandlerCubitState();
  }
}

class HaveImage extends ImageHandlerCubitState {
  var imageBase64;
  HaveImage({required this.imageBase64});
}

class HaveNotImage extends ImageHandlerCubitState {
  HaveNotImage();
}
