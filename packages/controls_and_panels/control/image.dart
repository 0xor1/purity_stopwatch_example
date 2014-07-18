/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Image extends Control{
  static const String CLASS = 'cnp-image';
  ImageElement _imageElement = new ImageElement();
  String get src => _imageElement.src;
  void set src (String src){ _imageElement.src = src; }
  String get alt => _imageElement.alt;
  void set alt (String alt){ _imageElement.alt = alt; }
  int get imgHeight => _imageElement.height;
  void set imgHeight (int height){ _imageElement.height = height; }
  int get imgWidth => _imageElement.width;
  void set imgWidth (int width){ _imageElement.width = width; }

  Image(String src, {String alt:'', int width: null, int height: null}){
    _imageStyle.insert();
    addClass(CLASS);
    _imageElement
      ..src = src
      ..alt = alt;
    if(width != null){
      this.imgWidth = width;
    }
    if(height != null){
      this.imgHeight = height;
    }
    html.children.add(_imageElement);
  }

  static final Style _imageStyle = new Style('''

    .$CLASS > img
    {
      display: block;
    }

  ''');
}