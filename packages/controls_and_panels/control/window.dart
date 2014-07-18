/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Window extends Control {

  static const String CLASS = 'cnp-window';
  static const String RESIZER = 'cnp-window-resizer';
  static const String HEADER = 'cnp-window-header';
  static const int _resizer_thickness = 6;
  static const int _header_thickness = 32;
  static const int _movementBuffer = 50;
  static const int _minSize = 50;

  final DivElement _topResizer = new DivElement()..classes.addAll([RESIZER, VAlign.TOP.toString()]);
  final DivElement _leftResizer = new DivElement()..classes.addAll([RESIZER, HAlign.LEFT.toString()]);
  final DivElement _bottomResizer = new DivElement()..classes.addAll([RESIZER, VAlign.BOTTOM.toString()]);
  final DivElement _rightResizer = new DivElement()..classes.addAll([RESIZER, HAlign.RIGHT.toString()]);
  final DivElement _topLeftResizer = new DivElement()..classes.addAll([RESIZER, VAlign.TOP.toString(), HAlign.LEFT.toString()]);
  final DivElement _bottomRightResizer = new DivElement()..classes.addAll([RESIZER, VAlign.BOTTOM.toString(), HAlign.RIGHT.toString()]);
  final DivElement _topRightResizer = new DivElement()..classes.addAll([RESIZER, VAlign.TOP.toString(), HAlign.RIGHT.toString()]);
  final DivElement _bottomLeftResizer = new DivElement()..classes.addAll([RESIZER, VAlign.BOTTOM.toString(), HAlign.LEFT.toString()]);

  final DivElement _header = new DivElement()..classes.add(HEADER);

  final DivElement _contentHolder = new DivElement()..classes.add(PagePanel.CONTENT_HOLDER);

  final StyleElement _windowStyleElement = new StyleElement()
  ..id = 'cnp-window-selection-style'
  ..text = '''
    * {
      -webkit-touch-callout: none;
      -webkit-user-select: none;
      -khtml-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
    }
  ''';

  final Base content;
  final Image icon;
  final String name;

  StreamSubscription _currentMouseMoveSub;

  int _top = 0;
  int get top => _top;
  void set top(int t) {
    _top = t < 0? 0: t > window.innerHeight - _movementBuffer? window.innerHeight - _movementBuffer: t;
    html.style.top = '${_top}px';
  }

  int _left = 0;
  int get left => _left;
  void set left(int l) {
    _left = l < 0? 0: l > window.innerWidth - _movementBuffer? window.innerWidth - _movementBuffer: l;
    html.style.left = '${_left}px';
  }

  int _width = 0;
  int get width => _width;
  void set width(int w) {
    _width = w < _minSize? _minSize: w > window.innerWidth - _left? window.innerWidth - _left: w;
    html.style.width = '${_width}px';
  }

  int _height = 0;
  int get height => _height;
  void set height(int h) {
    _height = h < _minSize? _minSize: h > window.innerHeight - _top? window.innerHeight - _top: h;
    html.style.height = '${_height}px';
  }

  int get right => _left + _width;

  int get bottom => _top + _height;

  factory Window(Base content, String name, int width, int height, int top, int left, [Image icon]){
    icon = icon != null? icon: new Image('', width: 0, height: 0);
    return new Window._internal(content, name, width, height, top, left, icon);
  }

  Window._internal(this.content, this.name, int width, int height, int top, int left, this.icon) {
    _windowStyle.insert();
    addClass(CLASS);
    _arrangeHtml();
    _hookUpEvents();
    setWindowSize(width, height);
    setWindowPosition(top, left);
  }

  void _arrangeHtml() {
    html.children.addAll([
      _contentHolder,
      _topResizer,
      _leftResizer,
      _bottomResizer,
      _rightResizer,
      _topLeftResizer,
      _bottomRightResizer,
      _topRightResizer,
      _bottomLeftResizer,
      _header]);
    _header.append((
      new StackPanel(Orientation.HORIZONTAL, [
        icon, new Label(name)])
      ..fill()).html);
    _contentHolder.append((content).html);
  }

  void _hookUpEvents(){
    html.onMouseDown.listen((_){
      var windows = PagePanel._singleton._floatAnchor.children;
      for(var insertIdx = windows.indexOf(html); insertIdx < windows.length - 1; insertIdx++){
        windows.insert(insertIdx, windows[insertIdx + 1]);
      }
    });
    _topResizer.onMouseDown.listen((MouseEvent event){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      int startBottom = bottom;
      _currentMouseMoveSub = window.onMouseMove.listen((MouseEvent event){
        _handleTopMouseMove(event, startBottom);
      });
    });
    _leftResizer.onMouseDown.listen((MouseEvent event){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      int startRight = right;
      _currentMouseMoveSub = window.onMouseMove.listen((MouseEvent event){
        _handleLeftMouseMove(event, startRight);
      });
    });
    _bottomResizer.onMouseDown.listen((_){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      _currentMouseMoveSub = window.onMouseMove.listen(_handleBottomMouseMove);
    });
    _rightResizer.onMouseDown.listen((_){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      _currentMouseMoveSub = window.onMouseMove.listen(_handleRightMouseMove);
    });
    _topLeftResizer.onMouseDown.listen((_){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      int startBottom = bottom;
      int startRight = right;
      _currentMouseMoveSub = window.onMouseMove.listen((MouseEvent event){
        _handleTopMouseMove(event, startBottom);
        _handleLeftMouseMove(event, startRight);
      });
    });
    _bottomRightResizer.onMouseDown.listen((_){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      _currentMouseMoveSub = window.onMouseMove.listen((MouseEvent event){
        _handleBottomMouseMove(event);
        _handleRightMouseMove(event);
      });
    });
    _topRightResizer.onMouseDown.listen((_){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      int startBottom = bottom;
      _currentMouseMoveSub = window.onMouseMove.listen((MouseEvent event){
        _handleTopMouseMove(event, startBottom);
        _handleRightMouseMove(event);
      });
    });
    _bottomLeftResizer.onMouseDown.listen((_){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      int startRight = right;
      _currentMouseMoveSub = window.onMouseMove.listen((MouseEvent event){
        _handleBottomMouseMove(event);
        _handleLeftMouseMove(event, startRight);
      });
    });
    _header.onMouseDown.listen((MouseEvent event){
      _attachWindowMouseUpEvent();
      _cancelCurrentMouseMoveSubIfNecessary();
      int initOffsetX = event.client.x - left;
      int initOffsetY = event.client.y - top;
      _currentMouseMoveSub = window.onMouseMove.listen((MouseEvent event){
        left = event.client.x - initOffsetX;
        top = event.client.y - initOffsetY;
      });
    });
  }

  void show(){
    var page = PagePanel._singleton;
    if(page != null){
      page._floatAnchor.append(html);
    }
  }

  void hide(){
    html.remove();
  }

  void _handleTopMouseMove(MouseEvent event, int startBottom) {
    if(event.client.y > startBottom - _minSize){
      top = startBottom - _minSize;
      height = _minSize;
    }else{
      top = event.client.y;
      height = startBottom - top;
    }
  }

  void _handleLeftMouseMove(MouseEvent event, int startRight) {
    if(event.client.x > startRight - _minSize){
      left = startRight - _minSize;
      width = _minSize;
    }else{
      left = event.client.x;
      width = startRight - left;
    }
  }

  void _handleBottomMouseMove(MouseEvent event) {
    height = event.client.y - top;
  }

  void _handleRightMouseMove(MouseEvent event) {
    width = event.client.x - left;
  }

  void _cancelCurrentMouseMoveSubIfNecessary(){
    if(_currentMouseMoveSub != null){
      _currentMouseMoveSub.cancel();
    }
  }

  void _attachWindowMouseUpEvent(){
    document.head.append(_windowStyleElement);
    StreamSubscription windowMouseUpSub;
    windowMouseUpSub = window.onMouseUp.listen((_){
      _windowStyleElement.remove();
      if(_currentMouseMoveSub != null){
        _currentMouseMoveSub.cancel();
        windowMouseUpSub.cancel();
      }
    });
  }

  void setWindowPosition(int top, int left) {
    this.top = top;
    this.left = left;
  }

  void setWindowSize(int width, int height) {
    this.width = width;
    this.height = height;
  }

  static final Style _windowStyle = new Style('''  

    .$CLASS
    {
      position: absolute;
      background: #ccc;
      border: 1px solid #aaaaaa;
    }

    .$CLASS
      > *
    {
      position: absolute;
      top: 0;
      left: 0;
      bottom: 0;
      right: 0;
      background: rgba(0,0,0,0);
    }

    .$CLASS
      > .$RESIZER.${VAlign.TOP}
    {
      bottom: calc(100% - ${_resizer_thickness}px);
      cursor: ns-resize;
    }

    .$CLASS
      > .$RESIZER.${HAlign.LEFT}
    {
      right: calc(100% - ${_resizer_thickness}px);
      cursor: ew-resize;
    }

    .$CLASS
      > .$RESIZER.${VAlign.BOTTOM}
    {
      top: calc(100% - ${_resizer_thickness}px);
      cursor: ns-resize;
    }

    .$CLASS
      > .$RESIZER.${HAlign.RIGHT}
    {
      left: calc(100% - ${_resizer_thickness}px);
      cursor: ew-resize;
    }

    .$CLASS
      > .$RESIZER.${VAlign.TOP}.${HAlign.LEFT} ,
    .$CLASS
      > .$RESIZER.${VAlign.BOTTOM}.${HAlign.RIGHT}
    {
      cursor: nw-resize;
    }

    .$CLASS
      > .$RESIZER.${VAlign.TOP}.${HAlign.RIGHT} ,
    .$CLASS
      > .$RESIZER.${VAlign.BOTTOM}.${HAlign.LEFT}
    {
      cursor: ne-resize;
    }

    .$CLASS
      > .${PagePanel.CONTENT_HOLDER}
    {
      top: ${(_resizer_thickness * 2) + _header_thickness}px;
      left: ${_resizer_thickness}px;
      right: ${_resizer_thickness}px;
      bottom: ${_resizer_thickness}px;
      background: #fff;
      border: 1px solid #aaaaaa;
    }

    .$CLASS
      > .$HEADER
    {
      top: ${_resizer_thickness}px;
      left: ${_resizer_thickness}px;
      right: ${_resizer_thickness}px;
      bottom: calc(100% - ${_resizer_thickness + _header_thickness}px);
      overflow: hidden;
      cursor: move;
      background: #fff;
      border: 1px solid #aaaaaa;
    }

  ''');
}


