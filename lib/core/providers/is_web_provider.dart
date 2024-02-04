import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isWebProvider = Provider<bool>((_) => kIsWeb);