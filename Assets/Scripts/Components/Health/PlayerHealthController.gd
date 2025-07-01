#This class holds all bespoke health logic for the player character
class_name PlayerHealthController extends HealthController

var max_health_cap:int = 20 #The maximum amount of pip a player can have, 10 total hearts.

signal max_health_changed() #For the UI

#GainMaxHealth(value)
#value: The amount of pips to gain
#Adds pip containers to the player

func GainMaxHealth(value):
	max_health = min(max_health + value, max_health_cap)
	max_health_changed.emit()


func _on_collision_shape_2d_visibility_changed():
	pass # Replace with function body.
