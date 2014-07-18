/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

/**
 * Simplifies binding commands to a [CommandLine] using a consistent user syntax.
 *
 * commands must come in the form <command> <positional-arg-i> /<named-arg-name-j>=<named-arg-value-j>
 * for any length of i and j. Note that all arguments must be seperated by spaces, all positional arguments
 * must come before named arguments, the name of named arguments must be prefixed with a / character and are
 * immediately joined to the value by a = character. if an argument value is a string with spaces in it, it
 * should be wrapped in single or double quotes ensuring any quote characters used in the string value itself
 * are of the opposite type, and no value may start with a " or ' unless it is a string that is ended with
 * the same character. To get the description of a command simply enter the <command> ?.
 *
 * Examples:
 *
 * * without named arguments:
 *   > foo 3 4 'John says "Hi" from a positional argument.'
 * * with a named argument:
 *   > bar 3 4 /text="John says 'Hi' from a named argument."
 * * get a command description:
 *   > add ?
 */
class CommandLineInputBinder{

  final CommandLine commandLine;
  final List<CommandLineBinding> _bindings = new List<CommandLineBinding>();

  CommandLineInputBinder(this.commandLine){
    _hookUpEvents();
    _addDefaultBindings();
  }

  void _hookUpEvents(){
    commandLine.onUserEntry.listen((String input){
      //get binding
      input = input.trim();
      var cmdEndIdx = _indexOfFirstSpaceOrStringLength(input, 1);
      var cmd = input.substring(0, cmdEndIdx);
      if(cmd == null || cmd == ''){
        return;
      }
      CommandLineBinding binding;
      try{
        binding = _bindings.singleWhere((binding) => binding.command == cmd);
      }on StateError catch(error){
        commandLine.enterText('ERROR: <$cmd> is not a known command, enter ? to see a list of valid commands');
        return;
      }
      //check for help request
      input = input.substring(cmdEndIdx);
      if(input.trim().startsWith('?')){
        commandLine.enterText(binding.description);
        return;
      }
      //parse args
      var posArgs = new List<String>();
      var namArgs = new Map<String, String>();
      try{
        _parseArguments(input, posArgs, namArgs);
      }catch(ex){
        commandLine.enterText('ERROR: failed to parse arguments');
        return;
      }
      //invoke binding
      binding.handler(commandLine, posArgs, namArgs);
    });
  }

  int _indexOfFirstSpaceOrStringLength(String str, [int start = 0]){
    if(str.length == 0){
      return 0;
    }
    var idx = str.indexOf(' ', start);
    return idx != -1? idx: str.length;
  }

  void _parseArguments(String argStr, List<String> posArgs, Map<String, String> namArgs){
    argStr = argStr.trim();
    while(argStr.length > 0 && !argStr.startsWith('/')){
      int endIdx;
      String arg;
      if(argStr.startsWith("'") || argStr.startsWith('"')){
        endIdx = argStr.indexOf(argStr.substring(0, 1), 1);
        arg = argStr.substring(1, endIdx);
        argStr = argStr.substring(endIdx + 1).trim();
      }else{
        endIdx = _indexOfFirstSpaceOrStringLength(argStr, 1);
        arg = argStr.substring(0, endIdx);
        argStr = argStr.substring(endIdx).trim();
      }
      posArgs.add(arg);
    }
    while(argStr.length > 0){
      int endIdx;
      String argName;
      String argValue;
      if(!argStr.startsWith('/')){
        throw new Exception('Expecting a named argument starting with the / character, but found: $argStr');
      }
      endIdx = argStr.indexOf('=');
      argName = argStr.substring(1, endIdx);
      argStr = argStr.substring(endIdx + 1);
      if(argStr.startsWith("'") || argStr.startsWith('"')){
        endIdx = argStr.indexOf(argStr.substring(0, 1), 1);
        argValue = argStr.substring(1, endIdx);
        argStr = argStr.substring(endIdx + 1).trim();
      }else{
        endIdx = _indexOfFirstSpaceOrStringLength(argStr, 1);
        argValue = argStr.substring(0, endIdx);
        argStr = argStr.substring(endIdx).trim();
      }
      namArgs[argName] = argValue;
    }
  }

  void add(CommandLineBinding binding){
    var existingIdx = binarySearch(
      _bindings,
      binding,
      compare: (CommandLineBinding a, CommandLineBinding b) => a.command.compareTo(b.command));
    if(existingIdx != -1){
      throw new DuplicateCommandLineBindingError(binding, _bindings[existingIdx]);
    }else{
      _bindings.add(binding);
      insertionSort(
        _bindings,
        compare: (CommandLineBinding a, CommandLineBinding b) => a.command.compareTo(b.command));
    }
  }

  void addAll(Iterable<CommandLineBinding> bindings){
    bindings.forEach((cmdLnB) => add(cmdLnB));
  }

  bool remove(CommandLineBinding binding){
    var existingIdx = binarySearch(
      _bindings,
      binding,
      compare: (CommandLineBinding a, CommandLineBinding b) => a.command.compareTo(b.command));
    if(existingIdx != -1){
      _bindings.removeAt(existingIdx);
    }
  }

  void removeAll(Iterable<CommandLineBinding> bindings) => bindings.forEach((binding) => remove(binding));

  void _addDefaultBindings(){
    addAll([
      new CommandLineBinding(
        '?',
        'Prints a simple how-to statement and lists all available commands',
        (CommandLine cmdLn, List<String> posArgs, Map<String, String> namArgs){
        cmdLn.enterText('Enter commands in the format:');
        cmdLn.enterBlankLines();
        cmdLn.enterText('<command> <positionalArg-i> /<namedArg-name-j>=<namedArg-value-j>');
        cmdLn.enterBlankLines();
        cmdLn.enterText('''For any integer i and j >= 0. To enter string values with spaces in them or which
        start with a / character, surround them with either " or ' characters, ensuring any quote marks within 
        the string value are of the opposite type. To select a previously entered command use CTRL+UP and CTRL+DOWN
        to auto cycle through previous inputs. To print the description for a single command run:''');
        cmdLn.enterBlankLines();
        cmdLn.enterText('<command> ?');
        cmdLn.enterBlankLines();
        cmdLn.enterText('Available commands:');
        cmdLn.enterBlankLines();
        _bindings.forEach((binding){
          cmdLn.enterText(binding.command);
        });
      })
    ]);
  }
}