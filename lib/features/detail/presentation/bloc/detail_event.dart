abstract class DetailEvent {}

class AddToCart extends DetailEvent {}
class IncreaseQuantity extends DetailEvent {}
class DecreaseQuantity extends DetailEvent {}
class ToggleAddon extends DetailEvent {
  final String addon;
  ToggleAddon(this.addon);
}
