import SwiftGodot

@Godot
final class CardReleasedState: CardState {
	required init() {
		super.init()
		state = CardState.State.released.rawValue
	}

	required init(nativeHandle: UnsafeRawPointer) {
		super.init()
		state = CardState.State.released.rawValue
	}

	override func enter() {
		if let card = cardUI {
		card.Color.color = Color.purple
		card.State.text = "RELEASED"
		}
	}
}
