import Foundation
import SwiftGodot

@Godot
final class CardUI: Control {
	@BindNode var Color: ColorRect
	@BindNode var State: Label
	@BindNode var DropPointDetector: Area2D
	@BindNode var CardStateMachine: CardStateMachine
	#signal("reparent_requested", arguments: ["cardUI": CardUI.self])

	override func _ready () {
		CardStateMachine.onInit(self)
		guiInput.connect(onGUIInput)
		mouseEntered.connect(onMouseEntered)
		mouseExited.connect(onMouseExited)
	}

	override func _input(event: InputEvent) {
		CardStateMachine.onInput(event: event)
	}

	func onGUIInput(event: InputEvent) {
		CardStateMachine.onGUIInput(event: event)
	}

	func onMouseEntered() {
		CardStateMachine.onMouseEntered()
	}

	func onMouseExited() {
		CardStateMachine.onMouseExited()
	}
}
