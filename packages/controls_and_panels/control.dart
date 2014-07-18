/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

abstract class Control extends Base{

  static int _idSource = 0;
  static const String CLASS = 'cnp-control';
  static const String FOCUS = 'cnp-focus';
  static const String CONTROL_ID = 'cnp-control-id';
  static Control _currentFocus = null;
  static Control get currentFocus => _currentFocus;
  static String _namespace;
  static String get namespace => _namespace;
  static void set namespace (String ns){
    String oldNamespace = _namespace;
    _namespace = ns;
    querySelectorAll('.$CLASS')
    .forEach((Element element){
      if(oldNamespace != null){
        element.classes.remove(oldNamespace);
      }
      if(_namespace != null && _namespace != ''){
        element.classes.add(_namespace);
      }
    });
  }

  final int _id;
  int get controlId => _id;

  StreamController<Control> _blurController = new StreamController();
  Stream<Control> get onBlur => _blurController.stream.asBroadcastStream();

  void blur(){
    if(hasFocus){
      _currentFocus = null;
      html.classes.remove(FOCUS);
      _blurController.add(this);
    }
  }

  StreamController<Control> _focusController = new StreamController();
  Stream<Control> get onFocus => _focusController.stream.asBroadcastStream();
  bool get hasFocus => this == _currentFocus;

  void focus(){
    if(!hasFocus){
      if(_currentFocus != null){
        _currentFocus.blur();
      }
      _currentFocus = this;
      html.classes.add(FOCUS);
      _focusController.add(this);
    }
  }

  Control():
  _id = _idSource++{
    _controlStyle.insert();
    addClass(CLASS);
    html.dataset[CONTROL_ID] = _id.toString();

    if(_namespace != null){
      addClass(_namespace);
    }

    html.onClick.listen((event) => focus());
    html.onClick.listen((event) => focus());
  }


  static final Style _controlStyle = new Style('''
  
    .$CLASS 
    {
    }
  
  ''');
}