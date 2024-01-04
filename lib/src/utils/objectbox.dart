import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shotwot_frontend/objectbox.g.dart';
import 'package:shotwot_frontend/src/models/token.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store _store;

  /// A Box of notes.
  late final Box<Token> _tokenBox;

  ObjectBox._create(this._store) {
    _tokenBox = Box<Token>(_store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "shotwot"));
    return ObjectBox._create(store);
  }

    Stream<Token?> streamToken() {
    // Query for all notes, sorted by their date.
    // https://docs.objectbox.io/queries
    final builder = _tokenBox.query(Token_.id.equals(1));
    return builder
        .watch(triggerImmediately: true)
        // Map it to a list of notes to be used by a StreamBuilder.
        .map((query) => query.findUnique());
  }

  Token? getToken() => _tokenBox.get(1);

  int? putToken(Token token) => _tokenBox.put(token);

  void remove() => _tokenBox.removeAll();
}
