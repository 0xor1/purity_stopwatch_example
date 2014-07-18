/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

typedef void CommandHandler(CommandLine cmdLn, List<String> posArgs, Map<String, String> namArgs);

class CommandLineBinding{
  final String command;
  final String description;
  final CommandHandler handler;
  CommandLineBinding(this.command, this.description, this.handler);
}



