#This is the base component for ANYTHING with health
class_name HealthController extends Node

var max_health:float
var current_health:float

signal damaged
signal healed
signal died

func _ready():
	#hook up the signals
	damaged.connect(_on_health_changed)
	healed.connect(_on_health_changed)
	died.connect(_on_death)

#take_damage(damage_value)
#damage_value: A float that contains the amount of damage to take.
#Takes in a damage_value, and subtracts it from the current_health

func TakeDamage(damage_value:float):
	current_health -= damage_value
	damaged.emit()

#heal_damage(heal_value)
#heal_value: A float that contains the amount of health to heal.
#Takes in a heal_value, and adds it to current_health if it is below max_health
func HealDamage(heal_value:float):
	if(current_health<max_health):
		current_health = min(current_health + heal_value, max_health) #Makes sure the character doesn't go over max health
		healed.emit()

#_on_health_changed
#A signal reciever for the damaged and healed signal, holds all logic and behavior for health being changed.
func _on_health_changed():
	if(current_health <= 0):
		died.emit()

#_on_death
#A signal recieved for died, holds all logic and behavior for character death.
func _on_death():
	pass
