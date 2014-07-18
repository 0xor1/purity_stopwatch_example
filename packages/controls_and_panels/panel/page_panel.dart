/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class PagePanel<TBase extends Base> extends Panel<TBase>{

  static const String CLASS = 'cnp-page-panel';
  static const String FLOAT_ANCHOR = 'cnp-float-anchor';
  static const String CONTENT_HOLDER = 'cnp-content-holder';

  final DivElement _floatAnchor = new DivElement()
  ..classes.add(FLOAT_ANCHOR);
  final DivElement _contentHolder = new DivElement()
  ..classes.add(CONTENT_HOLDER);
  List<Window> _windows = new List<Window>();
  static PagePanel _singleton;

  factory PagePanel(TBase content){
    if(_singleton != null){
      return _singleton;
    }else{
      return _singleton = new PagePanel._internal(content);
    }
  }
  PagePanel._internal(TBase content){
    _pagePanelStyle.insert();
    addClass(CLASS);
    _arrangeHtml(content);
  }

  void _arrangeHtml(TBase content){
    html
    ..append(_contentHolder)
    ..append(_floatAnchor);
    if(content != null){
      add(content);
    }
  }

  void add(TBase item){
    if(items.length == 0){
      items.add(item);
      _contentHolder.children.add(item.html);
      return;
    }
    throw 'PagePanel already has one child and cannot accept anymore';
  }

  void insert(int index, TBase item){
    if(index == 0){
      add(item);
      return;
    }
    throw 'can only insert at index 0 on an PagePanel as it only accepts one child';
  }

  bool remove(TBase item){
    _contentHolder.children.remove(item.html);
    return items.remove(item);
  }

  TBase removeAt(int index){
    if(index == 0 && items.length == 1){
      var base = items.removeAt(0);
      _contentHolder.children.remove(base.html);
      return base;
    }
    return null;
  }

  static final Style _pagePanelStyle = new Style('''  

    .$CLASS
    {
      width: 100%;
      height: 100%;
    }

    .$CLASS
      > .$FLOAT_ANCHOR
    {
      position: absolute;
      width: 0;
      height: 0;
      top: 0;
      left: 0;
      overflow: visible;
    }

    .$CLASS
      > .$CONTENT_HOLDER
    {
      width: 100%;
      height: 100%;
    }

  ''');
}



