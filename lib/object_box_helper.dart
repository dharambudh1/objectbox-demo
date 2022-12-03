import 'package:objectbox_demo/model.dart';

import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<Details> details;

  ObjectBox._create(this.store) {
    details = Box<Details>(store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();

    if (Sync.isAvailable()) {
      final syncClient =
          Sync.client(store, 'ws://0.0.0.0:9999', SyncCredentials.none());
      syncClient.start();
    }

    return ObjectBox._create(store);
  }

  Details? getDetail(int id) => details.get(id);

  Stream<List<Details>> getDetails() {
    return details
        .query()
        .watch(triggerImmediately: true)
        .map((event) => event.find());
  }

  int insertDetail(Details data) => details.put(data);

  bool deleteDetail(int id) => details.remove(id);
}
