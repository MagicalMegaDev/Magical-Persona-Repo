#signal_bus.gd
# Global signal dispatch used to decouple high-level events across the project

extends Node

# Emitted whenever the player's health changes.
# current_health: New Health Value
# max_health: Player's current maximum health.
signal player_health_changed(current_health, max_health)
signal player_picked_up_item(pickup:Pickup)

#DEBUG
#Emitted when the room should be reset
signal reset_room

#Forwards player-health updates from any source.
func _on_player_health_changed(current_health, max_health):
	player_health_changed.emit(current_health, max_health)

#Sends the item off to the player to be collected
func _on_item_pickup(pickup:Pickup):
	player_picked_up_item.emit(pickup)

#DEBUG
#Broadcasts a room-reset
func _on_room_reset():
	reset_room.emit()
