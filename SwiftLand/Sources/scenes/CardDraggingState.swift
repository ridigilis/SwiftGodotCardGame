import SwiftGodot

@Godot
final class CardDraggingState: CardState {
	let DRAG_MINIMUM_THRESHOLD = 0.05
	var minimumDragTimeElapsed = false

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
			var thresholdTimer = getTree()?.createTimer(timeSec: DRAG_MINIMUM_THRESHOLD, processAlways: false)
			if let uiLayer = getTree()?.getFirstNodeInGroup("ui_layer") {
				card.reparent(newParent: uiLayer)
			}
			card.Color.color = Color.blue
			card.State.text = "DRAGGING"

			minimumDragTimeElapsed = false
			thresholdTimer?.timeout.connect { self.minimumDragTimeElapsed = true }
		}
	}

	override func onInput(event: InputEvent) {
		// mouse motion
		if event is InputEventMouseMotion {
			if let card = cardUI {
			card.setGlobalPosition(card.getGlobalMousePosition() - card.pivotOffset)
			}
		}

		// cancel
		if event.isActionPressed(action: "right_mouse") {
			emit(signal: CardState.transitionRequested, self, CardState.State.base.rawValue)
		}

		// confirm
		if minimumDragTimeElapsed && (event.isActionReleased(action: "left_mouse") || event.isActionPressed(action: "left_mouse")) {
			getViewport()?.setInputAsHandled()
			emit(signal: CardState.transitionRequested, self, CardState.State.released.rawValue)
		}
	}
}
