/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Button extends Control{
  static const String CLASS = 'cnp-button';
  Stream<MouseEvent> get onClick => html.onClick;
  Base _content;
  Base get content => _content;
  void set content(Base content){
    if(content != null){
      if(_content != null){
        html.children.remove(_content.html);
      }
      _content = content;
      html.children.add(content.html);
    }
  }

  Button(Base content){
    _buttonStyle.insert();
    addClass(CLASS);
    this.content = content;
  }

  factory Button.text(String text){
    return  new Button(new Label(text));
  }

  factory Button.icon(Image icon){
    return  new Button(icon);
  }

  factory Button.iconText(String iconPath, String text, {int iconWidth: null, int iconHeight: null}){
    return new Button(new StackPanel(Orientation.HORIZONTAL ,[
      new Image(iconPath, width: iconWidth, height: iconHeight),
      new Label(text)]));
  }

  static final Style _buttonStyle = new Style('''

    .$CLASS
    {
      white-space: nowrap;
      font-size: 0;
      transition: background 0.3s;
      background: #aaa;
      border: 1px solid #888;
      border-radius: 3px;
      padding: 2px 4px;
      cursor: pointer;
      line-height: 1;
      -webkit-touch-callout: none;
      -webkit-user-select: none;
      -khtml-user-select: none;
      -moz-user-select: -moz-none;
      -ms-user-select: none;
      user-select: none;
    }

    .$CLASS:hover
    {
      background: #ddd;
    }

    .$CLASS:active
    {
      background: #fff;
    }

    .$CLASS > .${Base.CLASS}
    {
      word-spacing: normal;
      font-size: 16px;
    }

  ''');
}



