import Foundation
import SwiftGodot

@Godot
class CardState: Node {
	@Export(.enum, "base, clicked, dragging, aiming, released") var state: Int = 0
	var cardUI: CardUI?

	#signal("transition_requested", arguments: ["from": CardState.self, "to": Int.self])

	func enter() {}
	func exit() {}
	func onInput(event: InputEvent) {}
	func onGUIInput(event: InputEvent) {}
	func onMouseEntered() {}
	func onMouseExited() {}

	required init() { super.init() }
	required init(nativeHandle: UnsafeRawPointer) { super.init(nativeHandle: nativeHandle) }

	enum State: Int {
	case base, clicked, dragging, aiming, released
}
}
