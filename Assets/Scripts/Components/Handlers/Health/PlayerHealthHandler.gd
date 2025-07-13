#This class holds all bespoke health logic for the player character
class_name PlayerHealthHandler extends HealthHandler

var max_health_cap:int = 20 #The maximum amount of pip a player can have, 10 total hearts.

func _ready():
	health_changed.connect(SignalBus._on_player_health_changed)
	current_health = max_health
	health_changed.emit(current_health, max_health)
	
#GainMaxHealth(value)
#value: The amount of pips to gain
#Adds pip containers to the player

func GainMaxHealth(value):
	max_health = min(max_health + value, max_health_cap)
	health_changed.emit(current_health, max_health)
