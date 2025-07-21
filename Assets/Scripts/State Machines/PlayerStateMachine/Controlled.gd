#Handles raw input from the player and converts it into signals that other nodes in the player can react to
class_name Controlled
extends State

var movement_direction:= Vector2.ZERO #What direction is the player moving in.
signal movement_direction_set(direction:Vector2) 

var shooting_direction:= Vector2.ZERO #What direction is the player shooting in.
signal shooting_direction_set(direction:Vector2) 

var secondary_skill := false #Is the player currently using their secondary skill?
signal secondary_skill_used

var utility_skill := false #Is the player currently using their utility skill?
signal utility_skill_used

var active_item := false #Is the player currently using their active item?
signal active_item_used

var consumable := false #Is the player currently using their consumable?
signal consumable_used

var item_pickup := false #Is the player currently picking up an item?
signal item_picked_up

#dictionary of all non-vector inputs
var input_mappings := {
	"secondary_skill": secondary_skill_used,
	"utility_skill": utility_skill_used,
	"active_item": active_item_used,
	"consumable": consumable_used,
	"item_pickup": item_picked_up
	
}
func update(delta):
	#Broadcast the most recent input values
	movement_direction_set.emit(movement_direction)
	shooting_direction_set.emit(shooting_direction)
	for input_name in input_mappings:
		if(get(input_name)):
			input_mappings[input_name].emit()
			set(input_name, false)

func _on_movement_input(new_direction:Vector2):
	movement_direction = new_direction

func _on_shooting_input(new_direction:Vector2):
	shooting_direction = new_direction

func _on_secondary_skill():
	secondary_skill = true
	
func _on_utility_skill():
	utility_skill = true

func _on_active_item():
	active_item = true
	
func _on_consumable():
	consumable = true
	
func _on_item_pickup():
	item_pickup = true
	
