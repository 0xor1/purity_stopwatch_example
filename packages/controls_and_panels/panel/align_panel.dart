/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */


part of controls_and_panels;

class AlignPanel<TBase extends Base> extends Panel<TBase>{

  static const String CLASS = 'cnp-align-panel';
  static const String ALIGN_OUTER_LAYOUT_ASSISTANT = 'cnp-align-outer-layout-assistant';
  static const String ALIGN_INNER_LAYOUT_ASSISTANT = 'cnp-align-inner-layout-assistant';

  DivElement _outerLayoutAssistant = new DivElement()
  ..classes.add(ALIGN_OUTER_LAYOUT_ASSISTANT);
  DivElement _innerLayoutAssistant = new DivElement()
  ..classes.add(ALIGN_INNER_LAYOUT_ASSISTANT);

  HAlign _horizontal;
  HAlign get horizontal => _horizontal == HAlign._H_CENTER? HAlign.CENTER: _horizontal;
  void set horizontal(HAlign ali){
    removeClass(_horizontal);
    if(ali != HAlign.LEFT && ali != HAlign.RIGHT){
      ali = HAlign._H_CENTER;
    }
    _horizontal = ali;
    addClass(_horizontal);
  }

  VAlign _vertical;
  VAlign get vertical => _vertical == VAlign._V_CENTER? VAlign.CENTER: _vertical;
  void set vertical(VAlign ali){
    removeClass(_vertical);
    if(ali != VAlign.TOP && ali != VAlign.BOTTOM){
      ali = VAlign._V_CENTER;
    }
    _vertical = ali;
    addClass(_vertical);
  }

  AlignPanel({HAlign horizontal: HAlign.CENTER, VAlign vertical: VAlign.CENTER}){
    _sizerPanelStyle.insert();
    this.horizontal = horizontal;
    this.vertical = vertical;
    html.children.add(
      _outerLayoutAssistant
      ..children.add(_innerLayoutAssistant));
    addClass(CLASS);
  }

  void add(TBase item){
    if(items.length == 0){
      items.add(item);
      _innerLayoutAssistant.children.add(item.html);
      return;
    }
    throw 'AlignPanel already has one child and cannot accept anymore';
  }

  void insert(int index, TBase item){
    if(index == 0){
      add(item);
      return;
    }
    throw 'can only insert at index 0 on an AlignPanel as it only accepts one child';
  }

  bool remove(TBase item){
    _innerLayoutAssistant.children.remove(item.html);
    return items.remove(item);
  }

  TBase removeAt(int index){
    if(index == 0 && items.length == 1){
      var base = items.removeAt(0);
      _innerLayoutAssistant.children.remove(base.html);
      return base;
    }
    return null;
  }

  static final Style _sizerPanelStyle = new Style('''

    .$CLASS
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
    {
      display: table;
      width: 100%;
      height: 100%;
      margin: 0;
      border: 0;
      padding: 0;
    }

    .$CLASS
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
    {
      width: 100%;
      height: 100%;
      display: table-cell;
    }

    .$CLASS.${HAlign.LEFT}
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
    {
      text-align: left;
    }

    .$CLASS.${HAlign.RIGHT}
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
    {
      text-align: right;
    }

    .$CLASS.${HAlign._H_CENTER}
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
    {
      text-align: center;
    }

    .$CLASS.${HAlign._H_CENTER}
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
          > *
    {
      text-align: left; /*undo the style above*/
    }

    .$CLASS.${VAlign.TOP}
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
    {
      vertical-align: top;
    }

    .$CLASS.${VAlign.BOTTOM}
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
    {
      vertical-align: bottom;
    }

    .$CLASS.${VAlign._V_CENTER}
      > .$ALIGN_OUTER_LAYOUT_ASSISTANT
        > .$ALIGN_INNER_LAYOUT_ASSISTANT
    {
      vertical-align: middle;
    }

  ''');
}



