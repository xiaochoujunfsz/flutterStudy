import 'package:redux/redux.dart';
import 'dart:async';

class EpicStore<State> {
  final Store<State> _store;

  EpicStore(this._store);

  State get state => _store.state;

  Stream<State> get onChange => _store.onChange;

  dynamic dispatch(dynamic action) {
    return _store.dispatch(action);
  }
}
