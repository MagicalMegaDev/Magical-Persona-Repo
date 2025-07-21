# Basic movement state for enemies.
class_name EnemyMovementState 
extends EnemyAIState

signal send_direction(direction:Vector2)
@export var movement_ai:EnemyMovementAI

func _ready():
	if(movement_ai):
		# Connect to pause/resume the AI when the state enters or exits
		state_entered.connect(movement_ai.resume)
		state_exited.connect(movement_ai.pause)

	
func enter(args:= {}):
	super(args)
	# Connect when entering so the movement handler recieves input
	send_direction.connect(state_machine.my_owner.movement_handler._on_direction_calculated)

func exit():
	super()
	# Disconnect when exiting so the movement handler stops recieving input
	send_direction.disconnect(state_machine.my_owner.movement_handler._on_direction_calculated)

func handle_input(event: InputEvent):
	super(event)
	pass

func update(delta):
	super(delta)
	if(movement_ai):
		send_direction.emit(movement_ai.get_direction())
	else:
		push_warning("EnemyMovementState.update(): movement_ai not assigned")

func physics_update(delta):
	super(delta)
	pass
