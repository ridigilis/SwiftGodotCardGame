import SwiftGodot

@Godot
final class CardDraggingState: CardState {
	required init() {
		super.init()
		state = CardState.State.dragging.rawValue
	}

	required init(nativeHandle: UnsafeRawPointer) {
		super.init()
		state = CardState.State.dragging.rawValue
	}

	override func enter() {
		if let card = cardUI {
		if let uiLayer = getTree()?.getFirstNodeInGroup("ui_layer") {
			card.reparent(newParent: uiLayer)
		}
		card.Color.color = Color.blue
		card.State.text = "DRAGGING"
		}
	}

	override func onInput(event: InputEvent) {
		if event is InputEventMouseMotion {
			if let card = cardUI {
			card.setGlobalPosition(card.getGlobalMousePosition() - card.pivotOffset)
			}
		}

		if event.isActionPressed(action: "right_mouse") {
			emit(signal: CardState.transitionRequested, self, CardState.State.base.rawValue)
		}

		if event.isActionReleased(action: "left_mouse") || event.isActionPressed(action: "left_mouse") {
			getViewport()?.setInputAsHandled()
			emit(signal: CardState.transitionRequested, self, CardState.State.released.rawValue)
		}
	}
}
