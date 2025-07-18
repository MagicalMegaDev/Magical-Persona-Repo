#signal_bus.gd
# Global signal dispatch used to decouple high-level events across the project

extends Node

# Emitted whenever the player's health changes.
# current_health: New Health Value
# max_health: Player's current maximum health.
signal player_health_changed(current_health, max_health)

#DEBUG
#Emitted when the room should be reset
signal reset_room

#Forwards player-health updates from any source.
func _on_player_health_changed(current_health, max_health):
	player_health_changed.emit(current_health, max_health)

#DEBUG
#Broadcasts a room-reset
func _on_room_reset():
	reset_room.emit()
