import SwiftGodot

@Godot
final class Hand: HBoxContainer {
	override func _ready() {
		for child in getChildren(){
			if let cardUI: CardUI = child as? CardUI {
				cardUI.connect(signal: CardUI.reparentRequested, to: self, method: "onCardUIReparentRequested")
			}
		}
	}

	@Callable func onCardUIReparentRequested(_ cardUI: CardUI) {
		 cardUI.reparent(newParent: self)
	}
}
