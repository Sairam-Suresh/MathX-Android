import 'package:mathx_android/constants.dart';
import 'package:share_plus/share_plus.dart';

void shareNote(Note note) {
  Share.share(note.base64EncodedLink);
}
