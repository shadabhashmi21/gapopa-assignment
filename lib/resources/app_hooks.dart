import 'package:flutter_hooks/flutter_hooks.dart';

class MutableValue<T> {
  MutableValue(this.value);

  T value;
}

///
/// A mutable value, changes to the value will not trigger rebuilds
///
MutableValue<T> useValue<T>(final T initialData) =>
    useMemoized(() => MutableValue(initialData));