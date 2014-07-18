/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class DuplicateCommandLineBindingError extends Error{

  final CommandLineBinding newBinding;
  final CommandLineBinding existingBinding;

  DuplicateCommandLineBindingError(this.newBinding, this.existingBinding);

}



