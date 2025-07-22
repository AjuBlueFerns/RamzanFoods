import 'package:crocurry/objectbox.g.dart';

class StoreProvider {
   Store? _store= Store(getObjectBoxModel());

  StoreProvider() {

    // _store = Store(getObjectBoxModel());
  }

  updateStore(String? directory) {
    _store = Store(
      getObjectBoxModel(),
      directory: directory,
    );
  }

  Store get store => _store!;
}
