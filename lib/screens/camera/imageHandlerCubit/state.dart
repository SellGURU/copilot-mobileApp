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
  var imageBase64;
  HaveImage({required this.imageByte, this.imageBase64});
}

class HaveNotImage extends ImageHandlerState {
  HaveNotImage();
}
