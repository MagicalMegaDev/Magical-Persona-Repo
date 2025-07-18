#RoomManager.gd
# Global node responsible for broadcasting events related to room state.
extends Node

#Emitted when the current room has been cleared of enemies.
signal room_cleared

func _ready():
	room_cleared.connect(SignalBus._on_room_reset)
