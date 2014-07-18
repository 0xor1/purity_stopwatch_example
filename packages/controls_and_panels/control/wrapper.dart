/*
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of controls_and_panels;

class Wrapper extends Control{
  static const String CLASS = 'cnp-wrapper';
  Wrapper.ForElement(Element el){
    addClass(CLASS);
    html.children.add(el);
  }
  Wrapper.ForHtmlString(String html){
    addClass(CLASS);
    this.html.appendHtml(html);
  }
}