extends Node

#func _on_player_health_changed(current_health, max_health)
#Signal redirector for player health changing, let anyone who wants to know about it know.

signal player_health_changed(current_health, max_health)
signal reset_room

func _on_player_health_changed(current_health, max_health):
	player_health_changed.emit(current_health, max_health)

#DEBUG
func _on_room_reset():
	reset_room.emit()
