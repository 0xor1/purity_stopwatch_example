/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */


part of controls_and_panels;

class TextArea extends Control{

  static const String CLASS = 'cnp-text-area';
  TextAreaElement _textArea = new TextAreaElement();
  String get value => _textArea.value;
  void set value (String str){
    _textArea.value = str == null? '': str;
  }

  String get placeholder => _textArea.placeholder;
  void set placeholder (String str){
    _textArea.placeholder = str == null? '': str;
  }

  int get rows => _textArea.rows;
  void set rows(int num){
    _textArea.rows = num;
  }

  int get cols => _textArea.cols;
  void set cols(int num){
    _textArea.cols = num;
  }

  TextArea({ int rows: 4, int cols: 50, String placeholder: ''}){
    _textAreaStyle.insert();
    addClass(CLASS);
    html.children.add(_textArea);
    _textArea
      ..onBlur.listen((_) => blur())
      ..onFocus.listen((_) => focus());
    this.placeholder = placeholder;
    this.rows = rows;
    this.cols = cols;
  }

  bool get disabled => _textArea.disabled;
  void set disabled(bool disabled){
    _textArea.disabled = disabled;
  }

  static final Style _textAreaStyle = new Style('''

    $CLASS
    {
    }

  ''');
}