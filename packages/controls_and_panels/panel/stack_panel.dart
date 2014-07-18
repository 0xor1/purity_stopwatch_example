/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class StackPanel<TBase extends Base> extends Panel<TBase>{

  static const String CLASS = 'cnp-stack-panel';

  Orientation _orientation;
  Orientation get orientation => _orientation;

  StackPanel(Orientation ori, [List<TBase> items]){
    _stackPanelStyle.insert();
    if(items != null){
      this.items.addAll(items);
      html.children.addAll(items.map((o) => o.html));
    }
    this._orientation = ori;
    addClasses([CLASS, ori]);
  }

  void add(TBase item){
    items.add(item);
    html.children.add(item.html);
  }

  void insert(int index, TBase item){
    items.insert(index, item);
    html.children.insert(index, item.html);
  }

  bool remove(TBase base){
    bool removed = items.remove(base);
    if(removed){
      html.children.remove(base.html);
    }
    return removed;
  }

  TBase removeAt(int index){
    TBase base = items.removeAt(index);
    if(base != null){
      html.children.remove(base.html);
    }
    return base;
  }

  static final Style _stackPanelStyle = new Style('''  
    
    .$CLASS.${Orientation.HORIZONTAL}
    {
      white-space: nowrap;
      font-size: 0;
    }
  
    .$CLASS.${Orientation.HORIZONTAL} 
      > .${Base.CLASS}
    {
      word-spacing: normal;
      vertical-align: middle;
      font-size: initial;
    }

    .$CLASS.${Orientation.VERTICAL}
      > .${Base.CLASS}
    {
      clear: left;
      float: left;
    }

    .$CLASS.${Orientation.VERTICAL}
    {
      white-space: normal;
    }

  ''');
}



