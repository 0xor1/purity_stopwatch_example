/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

final Map<String, String> _namespaces = new Map<String, String>();
String _currentNamespace = null;
int _currentNamespaceKeyCount = 0;

/**
 * Register a group of [Transmittable] types inside a [namespace].
 * [namespace] is the string that will be used when [Transmittable.toTranString]
 * is called. [namespaceFull] can be any string value, however it is recommended
 * the name of the package and, if appropriate, library are included, this is to
 * help with debugging if namespace clashes do occur.
 */
void registerTranTypes(String namespaceFull, String namespace, void registerTypes()){
  _registerTranTranTypes();
  try{
    if(_currentNamespace != null){
      throw new NestedRegisterTranTypesCallError(_currentNamespace, namespace);
    }
    if(namespace.contains(TSD)){
      throw new InvalidTranNamespaceError(namespace);
    }
    if(_namespaces.keys.contains(namespace)){
      throw new DuplicateTranNamespaceError(namespace, namespaceFull);
    }
    _namespaces[namespace] = namespaceFull;
    _currentNamespace = namespace;
    registerTypes();
  }finally{
    _currentNamespace = null;
    _currentNamespaceKeyCount = 0;
  }
}

/**
 * Register a [subtype] of [Transmittable] along with a [constructor] function.
 * Calls to this function can only be made inside the function body of the last argument of [registerTranTypes].
 * This is to ensure all registrations are properly namespaced.
 */
void registerTranSubtype(Type subtype,  TranConstructor constructor){
  _registerTranCodec(subtype, true, _processTranToString, (String s) => _processStringBackToTran(constructor(), s));
}

/**
 * Registers a [type] to make it transmittable.
 * Calls to this function can only be made inside the function body of the last argument of [registerTranTypes].
 * This is to ensure all registrations are properly namespaced.
 */
void registerTranCodec(Type type, TranEncode encode, TranDecode decode) =>_registerTranCodec(type, false, encode, decode);

void _registerTranCodec(Type type, bool isTranSubtype, TranEncode encode, TranDecode decode){
  if(_currentNamespace == null){
    throw new TranRegistrationOutsideOfNamespaceError(type);
  }
  if(_tranCodecsByType.containsKey(type)){
    throw new DuplicateTranTypeError(type);
  }
  String key = '$_currentNamespace${_GetNextKeyForCurrentNamespace()}';
  if(_tranCodecsByKey.containsKey(key)){
    throw new DuplicateTranKeyError(key);
  }
  _tranCodecsByKey[key] = _tranCodecsByType[type] = new _TranCodec(key, type, isTranSubtype, encode, decode);

}

String _GetNextKeyForCurrentNamespace(){
  StringBuffer keyBuff = new StringBuffer();
  int base = KEY_PIECES.length;
  int tempCount = _currentNamespaceKeyCount;
  do{
    int division = tempCount ~/ base;
    int remainder = tempCount - (division * base);
    keyBuff.write(KEY_PIECES[remainder]);
    if(division == 0){
      break;
    }
    tempCount = division;
  }while(true);
  _currentNamespaceKeyCount++;
  return keyBuff.toString();
}

/**
 * A function which takes an object of type [T] and returns
 * a [String] representation of that object.
 */
typedef String TranEncode<T>(T obj);

/**
 *  A function which takes a string representation of an
 *  object of type [T] and returns an instance of that object.
 */
typedef T TranDecode<T>(String str);

/**
 *  A function which returns a new empty Transmittable type.
 */
typedef T TranConstructor<T extends Transmittable>();

bool _tranTranTypesRegistered = false;
void _registerTranTranTypes(){
  if(_tranTranTypesRegistered){ return; }
  _tranTranTypesRegistered = true;
  registerTranTypes('transmittable', '', (){
    registerTranCodec(null, (o)=> '', (s) => null);
    registerTranCodec(_InternalPointer, (_InternalPointer ip) => ip._uniqueValueIndex.toString(), (String s) => new _InternalPointer(int.parse(s)));
    registerTranCodec(num, (num n) => n.toString(), (String s) => num.parse(s));
    registerTranCodec(int, (int i) => i.toString(), (String s) => int.parse(s));
    registerTranCodec(double, (double f) => f.toString(), (String s) => double.parse(s));
    registerTranCodec(String, (String s) => s, (String s) => s);
    registerTranCodec(bool, (bool b) => b ? 't' : 'f', (String s) => s == 't' ? true : false);
    registerTranCodec(List, _processIterableToString, (String s) => _processStringBackToListOrSet(new List(), s));
    registerTranCodec(Set, _processIterableToString, (String s) => _processStringBackToListOrSet(new Set(), s));
    registerTranCodec(Map, _processMapToString, _processStringBackToMap);
    registerTranCodec(RegExp, _processRegExpToString, _processStringBackToRegExp);
    registerTranCodec(Type, (Type t) => _processTypeToString(t),(String s) => _tranCodecsByKey[s]._type);
    registerTranCodec(DateTime, (DateTime d) => d.toString(), (String s) => DateTime.parse(s));
    registerTranCodec(Duration, (Duration dur) => dur.inMilliseconds.toString(), (String s) => new Duration(milliseconds: num.parse(s)));
    registerTranCodec(Symbol, (Symbol sy) => MirrorSystem.getName(sy), (String s) => MirrorSystem.getSymbol(s));
    registerTranSubtype(Transmittable, () => new Transmittable());
  });
}