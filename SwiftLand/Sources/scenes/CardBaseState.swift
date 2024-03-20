import SwiftGodot

@Godot
final class CardBaseState: CardState {
	required init() {
		super.init()
		state = CardState.State.base.rawValue
	}

	required init(nativeHandle: UnsafeRawPointer) {
		super.init()
		state = CardState.State.base.rawValue
	}

	override func enter() {
		if let card = cardUI {
			if !card.isNodeReady() {
				Task {
					await card.ready
				}
			}
			card.emit(signal: CardUI.reparentRequested, card)
			card.Color.color = Color.green
			card.State.text = "BASE"
			card.pivotOffset = Vector2.zero
		}
	}

	override func onGUIInput(event: InputEvent) {
		if event.isActionPressed(action: "left_mouse") {
			if let card = cardUI {
				card.pivotOffset = card.getGlobalMousePosition() - card.getGlobalPosition()
				emit(signal: CardState.transitionRequested, self, CardState.State.clicked.rawValue)
			}
		}
	}
}
