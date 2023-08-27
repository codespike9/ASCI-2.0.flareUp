import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/in_buisness_model.dart';

// Create a StateProvider to hold the selected category filter

final selectedCategoryFilterProvider =
    StateProvider<BusinessCategory?>((ref) => null);
