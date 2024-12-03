import 'dart:async';
import 'package:meta/meta.dart';

abstract base class Solution<T extends Object, U extends Object,
    S extends Object> {
  const Solution();

  call(String input, int i) {
    assert(i == 1 || i == 0, 'Input value must be 0 or 1');
    return i == 0
        ? first(primaryInputParser(input))
        : second(secondaryInputParser(input));
  }

  @protected
  FutureOr<T> first(S input);

  @protected
  FutureOr<U> second(S input);

  @protected
  S primaryInputParser(String str);

  @protected
  S secondaryInputParser(String str) {
    return primaryInputParser(str);
  }
}
