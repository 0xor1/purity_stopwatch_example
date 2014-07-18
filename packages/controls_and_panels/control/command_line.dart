/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class CommandLine extends Control{

  static const String CLASS = 'cnp-command-line';
  static const String USER_INPUT = 'cnp-user-input';
  static const String HISTORY_FEED = 'cnp-history-feed';
  static const String USER_INPUT_DISABLED = 'cnp-user-input-disabled';

  final StackPanel _rootLayout = new StackPanel(Orientation.VERTICAL);
  final StackPanel _historyFeed = new StackPanel(Orientation.VERTICAL)
  ..addClass(HISTORY_FEED);
  final TextArea _userInput = new TextArea(placeholder: 'enter commands here')
  ..addClass(USER_INPUT);

  final List<String> _userEntryHistory = new List<String>();

  int _userEntryScrollIdx = 0;
  int _userEntryHistoryLength = 100;
  int get userEntryMemoryLength => _userEntryHistoryLength;
  void set userEntryMemoryLength(int n){
    _userEntryHistoryLength = n >= 0? n: _userEntryHistoryLength;
    while(_userEntryHistory.length > _userEntryHistoryLength){
      _userEntryHistory.remove(_userEntryHistory.first);
    }
  }

  final StreamController<String> _userEntryController = new StreamController<String>();
  Stream<String> _onUserEntry;
  Stream<String> get onUserEntry => _onUserEntry != null? _onUserEntry: _onUserEntry = _userEntryController.stream.asBroadcastStream();

  /**
   * The string that will be prefixed before each entry into the history feed,
   * the default value is '> '
   */
  String entryPrefix = '> ';
  int _historyFeedLength = 200;
  int get historyFeedLength => _historyFeedLength;
  /**
   * Sets how many entries the history feed will hold before deleting the oldest entries,
   * the default value is 100.
   *  * [length] must be greater than 0.
   */
  void set hisotyFeedLength(int length){
    _historyFeedLength = length > 0? length: _historyFeedLength;
    while(_historyFeed.items.length > _historyFeedLength){
      _historyFeed.remove(_historyFeed.items.first);
    }
  }

  CommandLine(){
    _commandLineStyle.insert();
    addClass(CLASS);
    _arrangeHtml();
    _hookUpEvents();
  }

  void _arrangeHtml(){
    html.children.add((
      _rootLayout
      ..addAll([
        _historyFeed,
        _userInput])).html);
  }

  void _hookUpEvents(){
    _userInput.html.onKeyDown.listen((KeyboardEvent event){
      if(event.keyCode == KeyCode.ENTER){
        enterText('$entryPrefix${_userInput.value}');
        _userEntryController.add(_userInput.value);
        if(_userInput.value.trim().isNotEmpty){
          _userEntryHistory.add(_userInput.value.trim());
          _userEntryScrollIdx = _userEntryHistory.length;
        }
        _userInput.value = '';
      }
      if(event.ctrlKey && event.keyCode == KeyCode.UP){
        var idx = --_userEntryScrollIdx;
        idx = idx < 0? _userEntryScrollIdx = 0: idx >= _userEntryHistory.length? _userEntryScrollIdx = _userEntryHistory.length - 1: idx;
        _userInput.value = _userEntryHistory[idx];
      }
      if(event.ctrlKey && event.keyCode == KeyCode.DOWN){
        var idx = ++_userEntryScrollIdx;
        idx = idx < 0? _userEntryScrollIdx = 0: idx >= _userEntryHistory.length? _userEntryScrollIdx = _userEntryHistory.length - 1: idx;
        _userInput.value = _userEntryHistory[idx];
      }
    });
    _userInput.html.onKeyUp.listen((KeyboardEvent event){
      if(event.keyCode == KeyCode.ENTER){
        _userInput.value = '';
      }
    });
  }

  void disableUserInput(){
    addClass(USER_INPUT_DISABLED);
    _userInput.disabled = true;
  }

  void enabledUserInput(){
    removeClass(USER_INPUT_DISABLED);
    _userInput.disabled = false;
    _userInput.focus();
  }

  void enterBlankLines([int n = 2]){
    for(var i = 0; i < n; i++){
      enterText('');
    }
  }

  void enterText(String text) => enterBase(new Paragraph(text));

  void enterElement(Element element) => enterBase(new Wrapper.ForElement(element));

  void enterHtml(String html) => enterBase(new Wrapper.ForHtmlString(html));

  void enterBase(Base entry){
    _historyFeed.add(entry);
    entry.html.scrollIntoView(ScrollAlignment.BOTTOM);
    if(_historyFeed.items.length > historyFeedLength){
      _historyFeed.remove(_historyFeed.items.first);
    }
  }

  bool get userInputDisabled => _userInput.disabled;
  void set userInputDisabled(bool disabled){
    _userInput.disabled = disabled;
  }

  static final Style _commandLineStyle = new Style('''
    
    .$CLASS
      > .${StackPanel.CLASS}
    {
      width: 100%;
      height: 100%;
      background: #777;
    }

    .$CLASS
      > .${StackPanel.CLASS} *
    {
      width: 100%;
      background: #000;
      color: #3f3;
      font-family: "Lucida Console", Monaco, monospace;
      font-size: 14px;
    }

    .$CLASS
      > .${StackPanel.CLASS}
        > .${HISTORY_FEED}
    {
      height: calc(100% - 52px);
      margin-bottom: 2px;
      overflow-y: scroll;
    }

    .$CLASS.$USER_INPUT_DISABLED
      > .${StackPanel.CLASS}
        > .${HISTORY_FEED}
    {
      height: 100%;
    }

    .$CLASS
      > .${StackPanel.CLASS}
        > .${HISTORY_FEED}
          > .${Paragraph.CLASS}
    {
      word-wrap: break-word;
      margin-bottom: 5px;
    }

    .$CLASS
      > .${StackPanel.CLASS}
        > .${USER_INPUT}
    {
      height: 50px;
    }

    .$CLASS.$USER_INPUT_DISABLED
      > .${StackPanel.CLASS}
        > .${USER_INPUT}
    {
      height: 0;
    }

    .$CLASS
      > .${StackPanel.CLASS}
        > .${USER_INPUT} > textarea
    {
      width: 100%;
      height: 100%;
      margin: 0;
      border: 0;
      outline: 0;
      padding: 0;
      overflow-y: scroll;
      resize: none;
    }

  ''');
}