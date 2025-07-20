#Base class for enemy movement AI. Subclasses will implement specific pathing logic.
#Provides a standard interface for retrieving movement directions
class_name EnemyMovementAI 
extends Node

#The character that owns this AI Component
var my_character:BaseCharacter

#Sets the movement direction for this frame
func set_direction():
	pass

#Returns the desired movement direction for the character.
func get_direction() -> Vector2:
	if my_character:
		print("%s has generic pathing AI attached!" % my_character.name)
	else:
		push_warning("get_direction() somewhere but my_character is null")
	return Vector2.ZERO

#Pause and Resume functions to be called when the parent state is entered and exited.
func pause():
	pass
	
func resume():
	pass
