class_name HealthBar extends Control

const HEART_VALUE := 2 #The amount a single heart is worth. Hearts have two states: Full and Half, so they are worth two hitpoints.
var max_containers = 10 #The max number of heart containers the player can have. Each Container is representitive of two health.



#_on_player_health_changed
#signal reciever for when the player's health has been changed in any way.
#Value: The current value of the players health.
func _on_player_health_changed(value):
	pass
