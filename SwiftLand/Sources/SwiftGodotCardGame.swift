import SwiftGodot

let allNodes: [Wrapped.Type] = [
	CardUI.self,
	CardStateMachine.self,
	CardState.self,
	CardBaseState.self,
	CardClickedState.self,
	CardDraggingState.self,
	CardReleasedState.self,
]
#initSwiftExtension(cdecl: "swift_entry_point", types: allNodes)
