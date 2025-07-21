# Base class for all states used by the StateMachine.
# Each state defines how the entity should behave while active.
class_name State
extends Node

var state_machine:StateMachine
signal state_entered
signal state_exited

# Called when the state becomes active.
func enter(args:= {}):
	state_entered.emit()

# Called when the state is exited
func exit():
	state_exited.emit()

# Called everytime an input event is recieved
func handle_input(event: InputEvent):
	pass

# Called each _process call if active
func update(delta):
	pass

# Called each _physics_process call if active
func physics_update(delta):
	pass
