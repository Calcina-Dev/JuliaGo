// lib/utils/tooltip_manager.dart
typedef TooltipRemover = void Function();

class TooltipManager {
  static final List<TooltipRemover> _removers = [];

  static void register(TooltipRemover remover) {
    _removers.add(remover);
  }

  static void unregister(TooltipRemover remover) {
    _removers.remove(remover);
  }

  static void removeAll() {
    for (final rem in List<TooltipRemover>.from(_removers)) {
      rem();
    }
  }
}
