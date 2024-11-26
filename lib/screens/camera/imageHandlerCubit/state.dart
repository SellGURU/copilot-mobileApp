class ImageHandlerState {
  ImageHandlerState init() {
    return ImageHandlerState();
  }

  ImageHandlerState clone() {
    return ImageHandlerState();
  }
}

class HaveImage extends ImageHandlerState {
  var imageByte;
  HaveImage({required this.imageByte});
}

class HaveNotImage extends ImageHandlerState {
  HaveNotImage();
}
