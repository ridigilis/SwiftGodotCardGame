import SwiftGodot

@Godot
final class CardClickedState: CardState {
	required init() {
		super.init()
		state = CardState.State.clicked.rawValue
	}

	required init(nativeHandle: UnsafeRawPointer) {
		super.init()
		state = CardState.State.clicked.rawValue
	}

	override func enter() {
		if let card = cardUI {
		 card.Color.color = Color.orange
		 card.State.text = "CLICKED"
		 card.DropPointDetector.monitoring = true
		}
	}

	override func onInput(event: InputEvent) {
		if event is InputEventMouseMotion {
			emit(signal: CardState.transitionRequested, self, CardState.State.dragging.rawValue)
		}
	}
}
