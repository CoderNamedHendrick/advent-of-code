import 'dart:async';
import 'package:meta/meta.dart';

abstract base class Solution<T extends Object, U extends Object,
    S extends Object> {
  const Solution();

  call(String input, int i) {
    assert(i == 1 || i == 0, 'Input value must be 0 or 1');
    return i == 0 ? first(inputParser(input)) : second(inputParser(input));
  }

  @protected
  FutureOr<T> first(S input);

  @protected
  FutureOr<U> second(S input);

  @protected
  S inputParser(String str);
}
