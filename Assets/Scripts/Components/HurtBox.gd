class_name HurtBox extends Area2D

@export var my_owner:Node2D
var damage_tracker := true #Does this hurt box trigger damage? This is so that I can have it hook itself up dynamically.
signal contacted(stats:AttackStats, position:Vector2)

func _ready():
	assert(my_owner, "%s hurt box doesn't have an owner assigned!" % get_parent().name)
	if(my_owner is BaseCharacter):
		if(my_owner.health_handler):
			contacted.connect(my_owner.health_handler._on_take_damage)
		if(my_owner.knockback_controller):
			contacted.connect(my_owner.knockback_controller.calculate_knockback)
func _on_hit(stats:AttackStats, position):
	contacted.emit(stats, position)
