class_name EnemyMovementState extends EnemyAIState

signal send_direction(direction:Vector2)
@export var movement_ai:EnemyMovementAI

func _ready():
	state_entered.connect(movement_ai.resume)
	state_exited.connect(movement_ai.pause)

	
func enter(args:= {}):
	super(args)
	send_direction.connect(state_machine.my_owner.movement_handler._on_direction_calculated)

func exit():
	super()
	send_direction.disconnect(state_machine.my_owner.movement_handler._on_direction_calculated)

func handle_input(event):
	super(event)
	pass

func update(delta):
	super(delta)
	send_direction.emit(movement_ai.get_direction())

func physics_update(delta):
	super(delta)
	pass
