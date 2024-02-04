import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashtronaut/dash/phrases.dart';

final phraseStatusProvider =
    StateProvider<PhraseStatus>((_) => PhraseStatus.none);
