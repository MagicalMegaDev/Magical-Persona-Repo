class_name StateMachine
extends Node

var states := {}
var current_state:State
var my_owner:Node

func _ready():
	my_owner = get_parent()
	for child in get_children():
		if child is State:
			add_state(child)
	current_state = states.keys()[0]

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func _input(event):
	if current_state:
		current_state.handle_input(event)

func add_state(state:State):
	state.state_machine = self
	states[state.name] = state

func change_state(state_name:String, args := {}):
	var new_state = states.get(state_name)
	if not new_state:
		push_error("State %s does not exist" % state_name)
		return
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter(args)
