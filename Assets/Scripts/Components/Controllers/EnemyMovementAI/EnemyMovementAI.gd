class_name EnemyMovementAI extends Node

var my_character:BaseCharacter

signal direction_calculated(direction:Vector2)

#set_direction
#internal function to set the direction to be passed along in get_direction
func set_direction():
	pass

#get_direction
#Generic function, inherited pathing behaviors will use this to determine a direction and send a signal.
func get_direction() -> Vector2:
	print("%s has generic pathing AI attached" %  my_character.name)
	return Vector2.ZERO

#pause and resume functions to be called when the parent state is entered and exited.
func pause():
	pass
	
func resume():
	pass
