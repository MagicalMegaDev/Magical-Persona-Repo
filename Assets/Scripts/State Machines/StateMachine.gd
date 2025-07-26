class_name StateMachine
extends Node

var states := {} #All states belonging to this machine
var current_state:State #The currently active state
var my_owner:Node

@export var starting_state:State = null

func _ready():
	my_owner = get_parent()
	assert(my_owner is BaseCharacter, "%s is not at root, parent is: %s" % [name, get_parent().name])
	for child in get_children():
		if child is State:
			add_state(child)
			child.state_machine = self
	if(starting_state and states.has(starting_state.name)):
		current_state = starting_state
	else: 
		if(states.size() != 0):
			current_state = states.values()[0]
			print(get_parent().name + " state machine had no starting state set!")
		else:
			print(get_parent().name + " state machine has no states!")
	

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
