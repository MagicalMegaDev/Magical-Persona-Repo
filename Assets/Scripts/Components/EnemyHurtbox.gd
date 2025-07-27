#Component for HurtBoxes
#Emits Contacted to forward hit information to nodes
class_name EnemyHurtBox 
extends HurtBox

func _ready():
	super()
	add_to_group("Enemies")
	Utilities.set_multiple_collision_layers(self, [7], true, true)
	Utilities.set_multiple_collision_masks(self, [2,3,5], true, true)
