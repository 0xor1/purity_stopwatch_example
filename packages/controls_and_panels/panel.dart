/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

const String PANEL = 'cnp-panel';

abstract class Panel<TBase extends Base> extends Base{

  List<TBase> items = new List<TBase>();

  Panel(){
    _panelStyle.insert();
    html.classes.add(PANEL);
  }

  void add(TBase base);

  void addAll(Iterable<Base> items){
    items.forEach((item) => add(item));
  }

  void insert(int index, TBase base);

  bool remove(TBase base);

  void removeAll(Iterable<Base> items){
    items.forEach((item) => remove(item));
  }

  Base removeAt(int index);

  void clear(){
    while(items.length > 0){
      remove(items.last);
    }
  }

  static final Style _panelStyle = new Style('''

    .$PANEL
    {
    }

  ''');
}
