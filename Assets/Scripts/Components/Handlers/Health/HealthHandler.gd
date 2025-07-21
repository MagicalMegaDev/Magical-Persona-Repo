#HealthHandler.gd
#This is the base component for ANYTHING with health
class_name HealthHandler 
extends Node


var max_health := 1 #Maximum amount of health this character can have
var current_health := 1 #Current amount of health this character has

signal damaged #emits when this character is damaged
signal healed #emits when this character is healed

#emits when the characters health has been changed in any fashion
signal health_changed(current_health: int, max_health: int) 
signal died #emits when current health == 0

#store starting stats for this node
func _receive_stats(stats:CharacterStats):
	assert(stats, "%s attached HealthHandler has no stats!" % get_parent().name)
	max_health = stats.max_health

func _ready():
	current_health = max_health
	#hook up the signals
	if not damaged.is_connected(_on_health_changed): damaged.connect(_on_health_changed)
	if not healed.is_connected(_on_health_changed): healed.connect(_on_health_changed)

# Applies incoming damage to current_health
func _on_take_damage(stats:AttackStats, attacker_position:Vector2):
	var damage_value = stats.damage
	current_health = max( current_health - damage_value, 0)
	damaged.emit()

# Adds incoming heal to current_health
func heal_damage(heal_value:int):
	if(current_health<max_health):
		#Makes sure the character doesn't go over max health
		current_health = min(current_health + heal_value, max_health) 
		healed.emit()

# Reacts to any change in health and emits related signals
func _on_health_changed():
	if(current_health <= 0):
		died.emit()
	health_changed.emit(current_health, max_health)
