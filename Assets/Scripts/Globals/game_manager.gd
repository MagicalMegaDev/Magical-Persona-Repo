#game_manager.gd
#Provides global signals and utility functions used throughout the project

extends Node


# Emitted whenever any enemy dies so UI and other systems can react.
signal enemy_killed

# Returns an array containing the given node and all of its descendants.
func get_all_children(node, arr: Array) -> Array:
	if arr == null:
		arr = []
	arr.append(node)
	for child in node.get_children():
		get_all_children(child, arr)
	return arr

# Applies each numeric value in `input_mods` as a multiplier to `input`.
# Non-numeric modifiers are removed and reported.
func apply_modifiers(input:float, input_mods:Dictionary, source_name:String = "GameManager") -> float:
	if(input == null):
		push_error("%s: apply_modifiers recieved a null input" % source_name)
		return 0
	if(input_mods.is_empty()):
		return input
		
	var mods := input_mods.duplicate() #Failsafe to avoid messing up the original dictionary
	for key in mods.keys():
		var value = mods[key]
		if !(value is float or value is int): #If a non-number slipped it's way in there, remove and print a debug
			push_warning("%s: %s with value %s is not numeric and will be ignored" % [source_name, key, value])
			mods.erase(key)
			continue
		input *= value
	return input

#Applies logic and functionality whenever an enemy is killed.
func _on_any_enemy_death(enemy:BaseEnemy):
	enemy_killed.emit()
