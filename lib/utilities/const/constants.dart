import 'package:destino_quisqueya_front/generated/l10n.dart';

const double horizontalPadding = 16.0;
const double verticalPadding = 16.0;

class DocumentID {
  final int id;
  final String name;

  DocumentID({required this.id, required this.name});
}

List<DocumentID> documentTypes = [
  DocumentID(id: 1, name: S.current.documentId),
  DocumentID(id: 2, name: S.current.passport),
];
