class_name State
extends Node

var state_machine:StateMachine
signal state_entered
signal state_exited

func enter(args:= {}):
	state_entered.emit()

func exit():
	state_exited.emit()

func handle_input(event):
	pass

func update(delta):
	pass

func physics_update(delta):
	pass
