/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of transmittable;

final Map<String, _TranCodec> _tranCodecsByKey = new Map<String, _TranCodec>();
final Map<Type, _TranCodec> _tranCodecsByType = new Map<Type, _TranCodec>();

class _TranCodec{
  final bool _isTranSubtype;
  final String _key;
  final Type _type;
  final TranEncode _encode;
  final TranDecode _decode;
  const _TranCodec(String this._key, Type this._type, bool this._isTranSubtype, TranEncode this._encode, TranDecode this._decode);
}