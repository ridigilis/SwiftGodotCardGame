import Foundation
import SwiftGodot

@Godot
final class CardStateMachine: Node {
	@Export(.nodeType, "CardState") var initialState: CardState?
	var currentState: CardState?
	var states: [Int:CardState] = [:]

	required init() {
		super.init()
	}
	required init(nativeHandle: UnsafeRawPointer) {
		super.init(nativeHandle: nativeHandle)
	}

	func onInit(_ card: CardUI) {
		for child in getChildren() {
			if let cardState: CardState = child as? CardState {
					states[cardState.state] = cardState
					cardState.connect(signal: CardState.transitionRequested, to: self, method: "onTransitionRequested")
					cardState.cardUI = card
			}
		}
		if states[CardState.State.base.rawValue] != nil {
			initialState = states[CardState.State.base.rawValue]
			initialState!.enter()
			currentState = initialState
		}
	}

	func onInput(event: InputEvent) {
		if currentState != nil {
			currentState!.onInput(event: event)
		}
	}

	func onGUIInput(event: InputEvent) {
		if currentState != nil {
			currentState!.onGUIInput(event: event)
		}
	}

	func onMouseEntered() {
		if currentState != nil {
			currentState!.onMouseEntered()
		}
	}

	func onMouseExited() {
		if currentState != nil {
			currentState!.onMouseExited()
		}
	}

	@Callable func onTransitionRequested(from: CardState, to: Int) {
		if from != currentState {
			return
		}

		if let newState: CardState = states[to] {
					if currentState != nil { currentState!.exit() }

					newState.enter()
					currentState = newState
		}
	}
}
