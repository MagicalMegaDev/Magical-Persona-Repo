extends Node

const BASE_KNOCKBACK_STRENGTH := 100.0 #the baseline of all knockback

signal enemy_killed

#get_all_children(node, arr:=[]):
#Creates an array of every child in a node, looking for sub children
func get_all_children(node, arr:=[]):
	arr.append(node)
	for child in node.get_children():
		get_all_children(child, arr)
	return arr

#add_mods(input:float, input_mods:Dictionary)
#input = The value to be changed
#input_mods = the Dictionary of mod values to multipy the input by
#This function is to keep track of all modifiers to different stats, and apply them seperately.

func add_mods(input:float, input_mods:Dictionary) -> float:
	if(input == null):
		print("Something went wrong with add_mods")
		return 0
	if(input_mods.is_empty()):
		return input
	else:
		for key in input_mods:
			var value = input_mods[key]
			if !(value is float or value is int): #If a non-number slipped it's way in there, remove and print a debug
				print(key, " with value: ", value, " is not a number! Removing from ", input_mods, " in ", get_parent().name, " movement controller!")
				input_mods.erase(key)
			else:
				input *= value
		return input

func _on_any_enemy_death(enemy:BaseEnemy):
	print("Died")
	enemy_killed.emit()
