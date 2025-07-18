extends Node

signal room_cleared

func _ready():
	room_cleared.connect(SignalBus._on_room_reset)
