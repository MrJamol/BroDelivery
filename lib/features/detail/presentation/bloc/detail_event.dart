abstract class ItemDetailEvent {}

class AddToCart extends ItemDetailEvent {}
class IncreaseQuantity extends ItemDetailEvent {}
class DecreaseQuantity extends ItemDetailEvent {}
class ToggleAddon extends ItemDetailEvent {
  final String addon;
  ToggleAddon(this.addon);
}
