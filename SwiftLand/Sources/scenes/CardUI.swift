import Foundation
import SwiftGodot

@Godot
final class CardUI: Control {
	@BindNode var Color: ColorRect
	@BindNode var State: Label
	@BindNode var DropPointDetector: Area2D
	@BindNode var CardStateMachine: CardStateMachine
	var targets: [Node] = []

	#signal("reparent_requested", arguments: ["cardUI": CardUI.self])

	override func _ready () {
		CardStateMachine.onInit(self)
		guiInput.connect(onGUIInput)
		mouseEntered.connect(onMouseEntered)
		mouseExited.connect(onMouseExited)
		DropPointDetector.areaEntered.connect(onDropPointDetectorAreaEntered)
		DropPointDetector.areaExited.connect(onDropPointDetectorAreaExited)
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

	func onDropPointDetectorAreaEntered(area: Area2D) {
		if !targets.contains(area) {
			targets.append(area)
		}
	}

	func onDropPointDetectorAreaExited(area: Area2D) {
		targets = targets.filter { $0 != area }
	}
}
