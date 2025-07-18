extends Node



signal enemy_killed

#get_all_children(node, arr:=[] = null):
#Creates an array of every child in a node, looking for sub children
func get_all_children(node, arr:=[]):
	if arr == null:
		arr = []
	arr.append(node)
	for child in node.get_children():
		get_all_children(child, arr)
	return arr

#apply_modifiers(input: float, input_mods: Dictionary)
#input = The value to be changed
#input_mods = Dictionary containing multipliers for `input`
#Modifiers containing non-numeric values are ignored (and removed)
#This function keeps track of modifiers to different stats and applies them separately.

func apply_modifiers(input:float, input_mods:Dictionary) -> float:
	if(input == null):
		push_error("add_mods() received a null input")
		return 0
	if(input_mods.is_empty()):
		return input
		
	var mods := input_mods.duplicate() #Failsafe to avoid messing up the original dictionary
	for key in mods.keys():
		var value = mods[key]
		if !(value is float or value is int): #If a non-number slipped it's way in there, remove and print a debug
			push_warning("%s with value %s is not numeric and will be ignored" % [key, value])
			mods.erase(key)
			continue
		input *= value
	return input

func _on_any_enemy_death(enemy:BaseEnemy):
	enemy_killed.emit()
