import SwiftGodot

@Godot
final class CardReleasedState: CardState {
	var played: Bool = false

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

			if !card.targets.isEmpty {
				played = true
			}
		}
	}

	override func onInput(event: InputEvent) {
		 if played { return }
		 emit(signal: CardState.transitionRequested, self, CardState.State.base.rawValue)
	}
}
