class_name EnemyMovementAI extends Node

var my_character:BaseCharacter

signal direction_calculated(direction:Vector2)

func _ready():
	assert(my_character.movement_handler, "%s has pathing behavoir but no movement handler!" % my_character.name)
	direction_calculated.connect(my_character.movement_handler._on_direction_calculated)

#get_direction
#Generic function, inherited pathing behaviors will use this to determine a direction and send a signal.
func get_direction() -> Vector2:
	print("%s has generic pathing AI attached" %  my_character.name)
	return Vector2.ZERO
