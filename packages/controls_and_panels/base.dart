/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

abstract class Base{

  static const String CLASS = 'cnp-base';
  static const String FILL = 'cnp-fill';
  static const String CNP_STAGING_ELEMENT_ID = 'cnp-staging-element-id';

  static final DivElement _cnpStagingElement = new DivElement()
  ..id = CNP_STAGING_ELEMENT_ID
  ..style.position = 'absolute'
  ..style.width = '0'
  ..style.height = '0'
  ..style.margin = '0'
  ..style.border = '0'
  ..style.padding = '0'
  ..style.overflow = 'hidden';

  static bool _fillByDefault = false;

  static void setFillByDefault(){
    _fillByDefault = true;
  }

  static void setShrinkByDefault(){
    _fillByDefault = false;
  }

  final DivElement html = new DivElement();

  String get id => html.id;
  void set id(String id){ html.id = id; }

  CssStyleDeclaration get style => html.style;

  Base(){
    _baseStyle.insert();
    addClass(CLASS);
    stage();
    if(_fillByDefault){
      fill();
    }
  }

  void fill(){
    html.classes.add(FILL);
  }

  void unfill(){
    html.classes.remove(FILL);
  }

  void addClass(dynamic cssClass){
    if(cssClass is EnumValue){
      cssClass = cssClass.toString();
    }
    html.classes.add(cssClass);
  }

  void addClasses(List<dynamic> cssClasses){
    cssClasses.forEach((cssClass){
      addClass(cssClass);
    });
  }

  void removeClass(dynamic cssClass){
    if(cssClass is EnumValue){
      cssClass = cssClass.toString();
    }
    html.classes.remove(cssClass);
  }

  void removeClasses(List<dynamic> cssClasses){
    cssClasses.forEach((cssClass){
      removeClass(cssClass);
    });
  }

  void setSize(String width, String height, {String minWidth, String maxWidth, String minHeight, String maxHeight}){
    style
    ..width = width
    ..minWidth = minWidth == null? width: minWidth
    ..maxWidth = maxWidth == null? width: maxWidth
    ..height = height
    ..minHeight = minHeight == null? height: minHeight
    ..maxHeight = maxHeight == null? height: maxHeight;
  }

  bool get isOnPage{
    if(isStaged){
      return false;
    }
    Element el = html;
    while(el.parent != null){
      el = el.parent;
      if(el == document.body){
        return true;
      }
    }
    return false;
  }

  bool get isStaged => html.parent == _cnpStagingElement;

  void stage(){
    if(_cnpStagingElement.parent != document.body){
      document.body.children.add(_cnpStagingElement);
    }
    _cnpStagingElement.children.add(html);
  }

  static final Style _baseStyle = new Style('''

    .$CLASS
    {
      position: relative;
      display: inline-block;
      margin: 0;
      border: 0;
      padding: 0;
      overflow: hidden;
      line-height: 1;
    }

    .$CLASS.$FILL
    {
      width: 100%;
      height: 100%;
    }

  ''');
}

